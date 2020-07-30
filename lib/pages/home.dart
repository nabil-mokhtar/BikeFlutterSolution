import 'package:flutter/material.dart';
import 'package:shiref_bike/lists/rentable_list.dart';
import 'package:shiref_bike/lists/rented_list.dart';
import 'package:shiref_bike/widgets/shared.dart';

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
    return rentable_home_page();
  }
}
