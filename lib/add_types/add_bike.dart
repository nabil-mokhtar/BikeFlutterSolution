import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/pages/add.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class add_bike extends StatefulWidget {
  @override
  _add_bikeState createState() => _add_bikeState();
}

class _add_bikeState extends State<add_bike> {
  final _formkey = GlobalKey<FormState>();
  String _name_product,
      _descripto,
      _product_cost,
      _rent_cost,
      _rentperday,
      _rentperweek,
      _branch;
  File _image;
  List<Asset> _images = List<Asset>();

  bool photo_exist = false;

  Widget _textT() {
    return Text(
      'Add Bike',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        onSaved: (newValue) => _descripto = newValue,
        controller: holder,
        validator: (value) => value.length > 0 ? null : "enter description",
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
  final rentholder = TextEditingController();
  final rentholderd = TextEditingController();
  final rentholderw = TextEditingController();
  final bholder = TextEditingController();

  final priceholder = TextEditingController();

  clearTextInput() {
    idholder.clear();
    holder.clear();
    rentholder.clear();
    rentholderd.clear();
    rentholderw.clear();
    priceholder.clear();
    bholder.clear();
  }

  Widget _productname() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _name_product = val,
        // keyboardType: TextInputType.number,
        validator: (val) => val.length > 0 ? null : 'Enter correct name',
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Bike Model',
            hintText: 'ex. cycle pro , trinx ',
            icon: Icon(
              Icons.directions_bike,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _branchname() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: bholder,
        onSaved: (val) => _branch = val,
        // keyboardType: TextInputType.number,
        validator: (val) => val.length > 0 ? null : 'Enter correct name',
        decoration: InputDecoration(
          labelText: 'branch',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _priceinput() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: priceholder,
        onSaved: (val) => _product_cost = val,
        keyboardType: TextInputType.number,
        validator: (val) => val.length > 0 ? null : 'Enter correct price',
        decoration: InputDecoration(
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Product Cost',
            hintText: 'price will be displayed in site !  ',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _rentprice() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: rentholder,
        onSaved: (val) => _rent_cost = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent per month Cost',
            hintText: 'Rent per month',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _rentperdayprice() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: rentholderd,
        onSaved: (val) => _rentperday = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent per day Cost',
            hintText: 'Rent per day',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _rentperweekprice() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: rentholderw,
        onSaved: (val) => _rentperweek = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent per week  Cost',
            hintText: 'Rent per week',
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

  void _submit() {
    if (_formkey.currentState.validate() && photo_exist == true) {
      _formkey.currentState.save();
      clearTextInput();
      _upload(_image);
    } else {
      print('not !');
    }
  }

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

  bool _switchVal = false;
  bool _isEnabled = false;

  Widget _switch() {
    return Row(
      children: [
        Text('Rentable'),
        Center(
          child: Switch(
              value: this._switchVal,
              onChanged: (bool value) {
                setState(() {
                  this._switchVal = value;
                  this._isEnabled = !this._isEnabled;
                });
              }),
        )
      ],
    );
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    setState(() {
      this._image = File(image.path);
      this.photo_exist = true;
    });
  }
  // String _name_product, _descripto, _product_cost,_rent_cost;

  void _upload(File file) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? 0;
    final admin = prefs.getString('admin') ?? 0;
    print(admin);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "model": _name_product,
      "serial": "000",
      "availability": true,
      "rentability": _isEnabled,
      "availabilityDuration": " avilable",
      "description": _descripto,
      "sellPrice": _product_cost,
      "rentPerDay": _rentperday,
      "rentPerWeek": _rentperweek,
      "rentPerMonth": _rent_cost,
      "branche": _branch,
      "images": _images,
    });

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";
    dio.options.headers["Content-Type"] = "application/json";

    dio
        .post("http://nabilmokhtar.pythonanywhere.com/apiBike/", data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }
/* 
  uploadFile() async {
    var postUri =
        Uri.parse("http://hassanharby2000.pythonanywhere.com/Products/Bike/");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    request.files.add(new http.MultipartFile.fromBytes(
        'file', await File.fromUri(_image.path).readAsBytes(),
        contentType: new MediaType('image', 'jpeg')));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  } */

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
                    _productname(),
                    _switch(),
                    _camera(),
                    _priceinput(),
                    _rentprice(),
                    _rentperweekprice(),
                    _rentperdayprice(),
                    _description(),
                    _branchname(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
