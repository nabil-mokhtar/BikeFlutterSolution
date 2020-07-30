import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class main_bike {
  int _id;
  String _model;
  String _serial;
  String _image;
  bool _availability;
  bool _rentability;
  String _availabilityDuration;
  String _description;
  int _sellPrice;

  int _rentPerDay;
  int _rentPerWeek;
  int _rentPerMonth;
  int _branche;

  main_bike(
      this._id,
      this._model,
      this._serial,
      this._image,
      this._availability,
      this._rentability,
      this._availabilityDuration,
      this._description,
      this._sellPrice,
      this._rentPerDay,
      this._rentPerWeek,
      this._rentPerMonth,
      this._branche);

  int get_branch() {
    return _branche;
  }

  String get_model() {
    return _model;
  }

  String get_image() {
    return _image;
  }

  bool get_avliable() {
    return _availability;
  }

  int get_sell_price() {
    return _sellPrice;
  }

  String get_duration() {
    return _availabilityDuration;
  }

  String get_description() {
    return _description;
  }

  int get_per_day() {
    return _rentPerDay;
  }

  int get_per_week() {
    return _rentPerWeek;
  }

  int get_per_month() {
    return _rentPerMonth;
  }

  int get_id() {
    return _id;
  }

  String get_serial() {
    return _serial;
  }

  bool get_rent_avialble() {
    return _rentability;
  }
}

class for_rent {
  List<main_bike> _rentable_bikes = [];
  List<main_bike> _rented_bikes = [];
  Future<List<main_bike>> get_bikes(int r) async {
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
      if (u._availability == false && u._rentability == true) {
        _rented_bikes.add(u);
      }
      if (u._availability == true && u._rentability == true) {
        _rentable_bikes.add(u);
      }
    }
    if (r == 1)
      return _rentable_bikes;
    else
      return _rented_bikes;
  }
}
