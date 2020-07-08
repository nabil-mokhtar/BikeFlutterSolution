//import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/pages/add.dart';
import 'package:shiref_bike/widgets/shared.dart';

import '../main.dart';

class add_user extends StatefulWidget {
  @override
  _add_userState createState() => _add_userState();
}

class _add_userState extends State<add_user> {
  final _formkey = GlobalKey<FormState>();
  String _userid, _rentcost, _qr, _name, _passw;
  DateTime _date;
  TimeOfDay _time;

  bool _t = false, _d = false, _q = false;
  Widget _textT() {
    return Text(
      'Resigter your loyal customer only',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  final idholder = TextEditingController();

  Widget _idInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _userid = val,
        keyboardType: TextInputType.number,
        validator: (val) => val.length != 14 ? 'Enter correct ID number' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'UserId',
            hintText: 'national id required ',
            icon: Icon(
              Icons.face,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  final productholder = TextEditingController();

  Widget _username() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: productholder,
        onSaved: (val) => _name = val,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'User Name',
            hintText: 'fmaily name included',
            icon: Icon(
              Icons.perm_identity,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  final noteholder = TextEditingController();

  Widget _notes() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: noteholder,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'notes',
          hintText: 'descripe issue or discout status ',
        ),
        maxLines: 2,
      ),
    );
  }

  File _image;

  Widget _camera() {
    return ButtonBar(
      children: [
        IconButton(
          icon: Icon(Icons.camera_enhance),
          onPressed: () async => await getImage(),
          tooltip: 'shoot picture',
        )
      ],
    );
  }

  Widget _submitbtn() {
    return Center(
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          'Sell',
        ),
        onPressed: () {
          _submit();
        },
      ),
    );
  }

  clearTextInput() {
    idholder.clear();
    productholder.clear();
    holder.clear();
    noteholder.clear();
  }

  void _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      clearTextInput();
      _upload(_image);
      print(
          'id:$_userid , price :$_rentcost ,return Date: $_date ,return time: $_time ,CODE: $_qr ');
    } else {
      print('not !');
    }
  }

  final holder = TextEditingController();

  Widget _pass() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        obscureText: true,
        controller: holder,
        onSaved: (val) => _passw = val,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    setState(() {
      this._image = File(image.path);
    });
  }
  // String _name_product, _descripto, _product_cost,_rent_cost;

  void _upload(File file) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? 0;

    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "name": _name,
      "userid": _userid,
      "password": _passw,
    });

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";

    dio
        .post("http://hassanharby2000.pythonanywhere.com/", data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        _textT(),
                        _idInput(),
                        _username(),
                        _pass(),
                        _camera(),
                        //_notes(),
                        _submitbtn(),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
