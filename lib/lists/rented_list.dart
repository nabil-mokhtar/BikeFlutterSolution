import 'dart:async';

import 'package:shiref_bike/lists/main_list_for_rent.dart';
import 'package:flutter/material.dart';
import 'package:shiref_bike/result_data/rented_bike_data.dart';

class rented_home_page extends StatefulWidget {
  rented_home_page({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _rented_home_page_state createState() => _rented_home_page_state();
}

class _rented_home_page_state extends State<rented_home_page> {
  for_rent b = new for_rent();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Rented Bike"),
      ),
      body: Container(
        child: FutureBuilder(
          future: b.get_bikes(2),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].get_image()),
                    ),
                    title: Text(snapshot.data[index].get_model()),
                    subtitle: Text(snapshot.data[index].get_description()),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  data_rented_bike(snapshot.data[index])));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
