import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: Colors.grey[700],
    leading: Icon(
      Icons.directions_bike,
      color: Colors.blue[700],
    ),
    title: Text(
      '$title',
    ),
    actions: [
      IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.red[700],
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('token');
            SystemNavigator.pop();
          })
    ],
  );
}
