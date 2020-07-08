import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
//import 'package:shiref_bike/pages/add.dart';

import '../main.dart';

class add_service extends StatefulWidget {
  @override
  _add_serviceState createState() => _add_serviceState();
}

class _add_serviceState extends State<add_service> {
  final _formkey = GlobalKey<FormState>();
  String _name_service, _descripto, _service_cost;

  Widget _textT() {
    return Text(
      'Add service',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (newValue) => _descripto = newValue,
        controller: holder,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'discription',
        ),
        maxLines: 2,
      ),
    );
  }

  final idholder = TextEditingController();
  final holder = TextEditingController();

  clearTextInput() {
    idholder.clear();
    holder.clear();
  }

  Widget _nameservice() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _name_service = val,
        keyboardType: TextInputType.number,
        validator: (val) => val.length > 3 ? 'Enter correct ID number' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Service Name',
            hintText: 'service name ',
            icon: Icon(
              Icons.receipt,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  final priceholder = TextEditingController();

  Widget _priceinput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: priceholder,
        onSaved: (val) => _service_cost = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Service Cost',
            hintText: 'price will be displayed in site !  ',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _submitbtn() {
    return Center(
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          "Add",
        ),
        onPressed: () {
          _submit();
        },
      ),
    );
  }

  void _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      clearTextInput();
      _upload();

      // print('id:$_service_name ');
    } else {
      print('not !');
    }
  }

  void _upload() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";

    dio
        .post("http://hassanharby2000.pythonanywhere.com/", data: {
          "name": _name_service,
          "price": _service_cost,
          "description": _description
        })
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    _textT(),
                    _nameservice(),
                    _priceinput(),
                    _description(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
