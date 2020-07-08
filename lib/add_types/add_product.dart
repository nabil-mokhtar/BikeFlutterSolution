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

  Widget _productname() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _name_product = val,
        // keyboardType: TextInputType.number,
        validator: (val) => val.length > 3 ? 'Enter correct ID number' : null,
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
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      clearTextInput();
      _upload(_image);

      // print('id:$_service_name ');
    } else {
      print('not !');
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
      "name": _name_product,
      "description": _descripto,
      "sellprice": _product_cost,
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
