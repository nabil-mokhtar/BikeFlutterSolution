import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/pages/add.dart';

import '../main.dart';

class add_product extends StatefulWidget {
  @override
  _add_productState createState() => _add_productState();
}

class _add_productState extends State<add_product> {
  final _formkey = GlobalKey<FormState>();
  String _name_product, _descripto, _product_cost;
  File _image;
  bool _photo = false;

  Widget _textT() {
    return Text(
      'Add Product',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (newValue) => _descripto = newValue,
        validator: (value) => value.length > 0 ? 'Enter description ' : null,
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

  Widget _productname() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _name_product = val,
        // keyboardType: TextInputType.number,
        validator: (val) => val.length > 3 ? 'Enter correct name ' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
            hintText: 'Product name ',
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
        onSaved: (val) => _product_cost = val,
        keyboardType: TextInputType.number,
        validator: (value) => value.length > 0 ? 'Enter correct price' : null,
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
    if (_formkey.currentState.validate() && _photo == true) {
      _formkey.currentState.save();
      clearTextInput();
      _upload(_image);
    } else {
      print('error in validation');
    }
  }

  Widget _camera() {
    return ButtonBar(
      children: [
        IconButton(
          icon: Icon(Icons.camera_enhance),
          onPressed: () async => getImage(),
          tooltip: 'shoot picture',
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
      this._photo = true;
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
      "name": _name_product,
      "description": _descripto,
      "sellPrice": _product_cost,
      "availability": true,
      "branche": 1,
    });

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";
    dio.options.headers["Content-Type"] = "application/json";

    dio
        .post("http://nabilmokhtar.pythonanywhere.com/Products/Accessories/",
            data: data)
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
                    _productname(),
                    _camera(),
                    _priceinput(),
                    _description(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
