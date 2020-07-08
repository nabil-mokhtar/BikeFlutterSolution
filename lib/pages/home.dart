import 'package:flutter/material.dart';
import 'package:shiref_bike/lists/list_rentable_bike_home_scereen.dart';
import 'package:shiref_bike/widgets/shared.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: appBar("home"),
        body: DefaultTabController(
            length: 2,
            child: Builder(
                builder: (BuildContext context) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          TabPageSelector(),
                          Expanded(
                              child: TabBarView(
                                  children: [rentedView(), unrentedView()]))
                        ],
                      ),
                    ))),
      ),
      color: Colors.indigoAccent,
    );
  }
}

class rentedView extends StatefulWidget {
  @override
  _rentedViewState createState() => _rentedViewState();
}

class _rentedViewState extends State<rentedView> {
  @override
  Widget build(BuildContext context) {
    return rented_home_page();
  }
}

class unrentedView extends StatefulWidget {
  @override
  _unrentedViewState createState() => _unrentedViewState();
}

class _unrentedViewState extends State<unrentedView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




