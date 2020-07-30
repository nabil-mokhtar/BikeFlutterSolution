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
  String _phonenum;
  var Cami = Colors.grey;
  var Camu = Colors.grey;

  bool _t = false,
      _d = false,
      _q = false,
      f = false,
      flag1 = false,
      flag2 = false;
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
  final phoneholder = TextEditingController();

  File _image;
  File _userImage;

  Widget _ucamera() {
    return ButtonBar(
      children: [
        IconButton(
          icon: Icon(Icons.camera_enhance),
          color: Camu,
          onPressed: () async {
            try {
              await ugetImage();
            } catch (e) {
              setState(() {
                this.Camu = Colors.red;
              });
            }
          },
          tooltip: 'shoot picture',
        )
      ],
    );
  }

  Future ugetImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    setState(() {
      try {
        this._userImage = File(image.path);
        this.Camu = Colors.green;

        this.flag1 = true;
      } catch (e) {
        this.Camu = Colors.red;
      }
    });
  }
  // String _name_product, _descripto, _product_cost,_rent_cost;

  Widget _camera() {
    return ButtonBar(
      children: [
        IconButton(
          icon: Icon(Icons.camera_enhance),
          color: Cami,
          onPressed: () async {
            try {
              await getImage();
            } catch (e) {
              setState(() {
                this.Cami = Colors.red;
              });
            }
          },
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
          'Add',
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
    phoneholder.clear();
  }

  void _submit() {
    if (flag1 == true && flag2 == true) {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        clearTextInput();
        try {
          _upload(_image, _userImage);
        } catch (e) {
          print("connection error");
        }

        print(
            'id:$_userid , price :$_rentcost ,return Date: $_date ,return time: $_time ,CODE: $_qr ');
        setState(() {
          Cami = Colors.grey;
          Camu = Colors.grey;
          flag1 = false;
          flag2 = false;
        });
      } else {
        print('not !');
      }
    } else {
      fail();
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

  Widget _phone() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        obscureText: true,
        controller: phoneholder,
        onSaved: (val) => _phonenum = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Phone',
            icon: Icon(
              Icons.phone,
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
      try {
        this._image = File(image.path);
        this.flag2 = true;
        this.Cami = Colors.green;
      } catch (e) {
        this.Cami = Colors.red;
      }
    });
  }
  // String _name_product, _descripto, _product_cost,_rent_cost;

  void _upload(File file, File ufile) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? 0;
    String fileName;
    fileName = file.path.split('/').last;
    String ufileName = ufile.path.split('/').last;

    FormData data = FormData.fromMap({
      "idImage": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "userimage": await MultipartFile.fromFile(
        ufile.path,
        filename: ufileName,
      ),
      "name": _name,
      "userid": _userid,
      "password": _passw,
      "phone": _phonenum,
      "adress": "nulllll on id !",
    });

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";
    dio.options.headers["Content-Type"] = "application/json";

    dio
        .post("http://nabilmokhtar.pythonanywhere.com/User/User/", data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  Widget fail() {
    setState(() {
      this.Cami = Colors.red;
      this.Camu = Colors.red;
    });
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
                        _phone(),
                        Row(
                          children: <Widget>[
                            Text("id image"),
                            _camera(),
                            Text("user image"),
                            _ucamera(),
                          ],
                        ),
                        _submitbtn(),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
