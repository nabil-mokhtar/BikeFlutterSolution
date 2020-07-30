import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shiref_bike/lists/main_list_for_rent.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shiref_bike/pages/open_search_page.dart';

main_bike h;
List<main_bike> all_bikes = [];
Future get_bikes() async {
  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('token') ?? 0;
  // final admin = prefs.getString('admin') ?? 0;
  print(token);
  final http.Response response = await http.get(
    'http://nabilmokhtar.pythonanywhere.com/apiBike/',
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "token $token"
    },
  );

  print(response.statusCode);

  var josendata = json.decode(response.body);
  all_bikes.clear();
  for (var i in josendata) {
    main_bike u = main_bike(
        i["id"],
        i["model"],
        i["serial"],
        i["image"],
        i["availability"],
        i["rentability"],
        i["availabilityDuration"],
        i["description"],
        i["sellPrice"],
        i["rentPerDay"],
        i["rentPerWeek"],
        i["rentPerMonth"],
        i["branch"]);
    all_bikes.add(u);
  }
}

class search extends StatelessWidget {
  @override
  data_search s;
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
        title: Text("Search for bike"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: data_search());
              },
              icon: Icon(Icons.search))
        ],
      )),
    );
  }
}

class data_search extends SearchDelegate<main_bike> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return addd(context, h);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions\

    get_bikes();
    final mylist = query.isEmpty
        ? all_bikes
        : all_bikes.where((p) => p.get_model().startsWith(query)).toList();
    return mylist.isEmpty
        ? Text('NO Result')
        : ListView.builder(
            itemCount: mylist.length,
            itemBuilder: (context, index) {
              final main_bike bikeitem = mylist[index];
              return ListTile(
                  onTap: () {
                    h = bikeitem;
                    showResults(context);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(bikeitem.get_image()),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(bikeitem.get_model()),
                      Text(bikeitem.get_description()),
                      Divider()
                    ],
                  ));
            });
  }
}
