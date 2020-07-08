import 'package:shiref_bike/pages/actions/rent_action.dart';
import 'package:shiref_bike/pages/actions/sell_action.dart';
import 'package:flutter/material.dart';
import 'package:shiref_bike/pages/actions/close_rent.dart';
import 'package:shiref_bike/widgets/shared.dart';

class actions extends StatefulWidget {
  @override
  _actionsState createState() => _actionsState();
}

class _actionsState extends State<actions> {
  static const menuItems = <String>['sell', 'close rental', 'rent'];
  final List<DropdownMenuItem<String>> _dropDownMenu = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'sell';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: appBar("Actions"),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'action type ',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            trailing: DropdownButton<String>(
              value: _btn1SelectedVal,
              onChanged: (String newValue) {
                setState(() {
                  _btn1SelectedVal = newValue;
                });
              },
              items: this._dropDownMenu,
            ),
          ),
          actionReq(this._btn1SelectedVal)
        ],
      ),
    ));
  }
}

Center actionReq(String btn) {
  if (btn == 'rent') {
    return Center(
      child: rent_action(),
    );
  } else if (btn == 'sell') {
    return Center(
      child: sell_action(),
    );
  } else {
    return Center(
      child: close_rent(),
    );
  }
}
