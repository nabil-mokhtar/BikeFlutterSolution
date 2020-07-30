import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/services/api_service.dart';
import 'package:http/http.dart' as http;

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
  bool photo_exist = false;

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
        validator: (value) => value.length > 0 ? null : "enter descriptoin ",
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
    priceholder.clear();
  }

  Widget _nameservice() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _name_service = val,
        validator: (value) => value.length > 0 ? null : "enter service name",
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
        validator: (value) => value.length > 0 ? null : "enter price",
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
      addService();
      //_upload();
      // print('id:$_service_name ');
    } else {
      print('validation error');
    }
  }

  void _upload() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    Duration du = Duration(hours: 20);
    Dio dio = new Dio();
    dio.options.headers["Content-Type"] = "application/json";

    dio
        .post("http://hassanharby2000.pythonanywhere.com/Products/Service/",
            data: {
              "name": _name_service,
              "duration": "00:00:20",
              "price": _service_cost,
            })
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  Future<String> addService() async {
    final prefs = await SharedPreferences.getInstance();
    Duration du = Duration(hours: 20);
    int x = 20;

    final token = prefs.getString('token') ?? 0;
    final admin = prefs.getString('admin') ?? 0;
    print(token);
    final http.Response response = await http.post(
      'http://nabilmokhtar.pythonanywhere.com/Products/Service/',
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "token $token"
      },
      body: jsonEncode(<String, String>{
        "name": _name_service,
        "duration": "00:00:20",
        "price": _service_cost,
        // "description": _descripto,
        //"admin": "nabil"
      }),
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
    } else {
      //throw Exception('Failed to create bike');
      print(response.statusCode);
    }
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
