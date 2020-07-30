import 'package:flutter/material.dart';
import 'package:shiref_bike/lists/main_list_for_rent.dart';
import 'package:shiref_bike/pages/edits_bike.dart';
import 'package:shiref_bike/pages/search.dart';

class addd extends StatelessWidget {
  main_bike b;
  addd(context, main_bike b) {
    this.b = b;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            RaisedButton(
                color: Colors.blue,
                child: Text('Edit bike'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return edit_bike(this.b);
                  }));
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text('print Qr'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return null;
                  }));
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text('delete bike'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return null;
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
