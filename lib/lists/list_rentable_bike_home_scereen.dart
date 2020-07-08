import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/widgets/shared.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class rented_bike {
  int id;
  String model;
  String serial;
  String image;
  bool availability;
  bool rentability;
  String availabilityDuration ;
  String  description;
  int sellPrice;

  int rentPerDay;
  int rentPerWeek;
  int rentPerMonth;
  int branche;




  rented_bike(this.id,this.model,this.serial,this.image,this.availability,this.rentability,this.availabilityDuration
      ,this.description,this.sellPrice,this.rentPerDay,this.rentPerWeek,this.rentPerMonth
      ,this.branche);




  int get_branch(){
    return branche;
  }

  String get_model(){
    return model;
  }

  String get_image(){
    return image;
  }

  bool get_avliable(){
    return availability;
  }
  int get_sell_price(){
    return sellPrice;
  }

  String get_duration(){
    return availabilityDuration;
  }

  String get_description (){

    return description;
  }
  int get_per_day(){
    return rentPerDay;
  }
  int get_per_week(){
    return rentPerWeek;
  }
  int get_per_month(){
    return rentPerMonth;
  }
  int get_id(){
    return id;
  }
  String get_serial(){
    return serial;
  }
  bool get_rent_avialble(){
    return rentability;
  }


}
class rented_home_page extends StatefulWidget {
  rented_home_page({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _rented_home_page_state createState() => _rented_home_page_state();
}

class _rented_home_page_state extends State <rented_home_page>{
  @override

  Future<List<rented_bike>> _get_rentet_bikes() async{
    final prefs = await SharedPreferences.getInstance();


    final token = prefs.getString('token') ?? 0;
    // final admin = prefs.getString('admin') ?? 0;
    print(token);
    final http.Response response = await http.get(
      'http://nabilmokhtar.pythonanywhere.com/Products/Bike/',
      headers: {"Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "token $token"
      },
    );
    //var data= await http.get("http://nabilmokhtar.pythonanywhere.com/Products/Bike/");
    print(response.statusCode);

    var josendata= json.decode(response.body);
    List <rented_bike>bike=[];
    for(var i in josendata){
      rented_bike u=rented_bike(i["id"], i["model"], i["serial"], i["image"], i["availability"], i["rentability"], i["availabilityDuration"], i["description"], i["sellPrice"], i["rentperDay"], i["rentperWeek"], i["rentperMonth"], i["branch"]);
      bike.add(u);
    }

    print(bike.length);
    return bike;
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Rentable Bike"
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _get_rentet_bikes(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.requireData==null){
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
                    subtitle: Text(snapshot.data[index].description),

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
