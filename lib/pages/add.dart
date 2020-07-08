import 'package:flutter/material.dart';
import 'package:shiref_bike/add_types/add_bike.dart';
import 'package:shiref_bike/add_types/add_product.dart';
import 'package:shiref_bike/add_types/add_service.dart';
import 'package:shiref_bike/add_types/add_user.dart';
import 'package:shiref_bike/widgets/shared.dart';

import '../main.dart';

class add extends StatefulWidget {
  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBar('Add'),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            RaisedButton(
                color: Colors.blue,
                child: Text('Add Customer'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return add_user();
                  }));
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text('Add Service'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return add_service();
                  }));
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text('Add product'),
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return add_product();
                    }))),
            RaisedButton(
                color: Colors.blue,
                child: Text('Add Bike'),
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return add_bike();
                    }))),
            RaisedButton(
                color: Colors.blue,
                child: Text('Add Event'),
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return add_bike();
                    })))
          ],
        ),
      ),
    );
  }
}
