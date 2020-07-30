import 'package:shiref_bike/lists/main_list_for_rent.dart';
import 'package:flutter/material.dart';
import 'package:shiref_bike/result_data/rentable_bike_data.dart';

class rentable_home_page extends StatefulWidget {
  rentable_home_page({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _rentable_home_page_state createState() => _rentable_home_page_state();
}

class _rentable_home_page_state extends State<rentable_home_page> {
  for_rent b = new for_rent();
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Rentable Bike"),
      ),
      body: Container(
        child: FutureBuilder(
          future: b.get_bikes(1),
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
                                  data_rentable_bike(snapshot.data[index])));
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
