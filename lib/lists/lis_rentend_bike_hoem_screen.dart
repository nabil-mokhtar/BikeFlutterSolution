import 'package:flutter/material.dart';
import 'package:shiref_bike/lists/list_rentable_bike_home_scereen.dart';
import 'package:shiref_bike/widgets/shared.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



class rentable_bike {
  int _rent_cost_per_hour;
  String _name;
  String _image;
  String _model;
  rentable_bike(this._name,this._model,this._rent_cost_per_hour,this._image);

  String get_name(){
    return _name;
  }

  int get_rent_cost_per_hour(){
    return _rent_cost_per_hour;
  }

  String get_model(){
    return _model;
  }

  String get_picture(){
    return _image;
  }
}


class rentable_home_page extends StatefulWidget {
  rentable_home_page({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _rentable_home_page_state createState() => _rentable_home_page_state();
}

class _rentable_home_page_state extends State <rentable_home_page>{
  @override
  Future<List<rentable_bike>> _get_rentable_bikes() async{
    var data= await http.get("http://hassanharby2000.pythonanywhere.com/Products/Bike/");
    var josendata= json.decode(data.body);
    List < rentable_bike>rentable_bikes=[];
    for(var i in josendata){
      rentable_bike u=rentable_bike(i["name"], i["model"], i["rent_cost_per_hour"], i["image"]);
      rentable_bikes.add(u);
    }

    print(rentable_bikes.length);
    return rentable_bikes;
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Rentable Bike"
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _get_rentable_bikes(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );

            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(

                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data[index].image
                      ),
                    ),
                    title: Text(snapshot.data[index].model),
                    subtitle: Text(snapshot.data[index].sellPrice),

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

