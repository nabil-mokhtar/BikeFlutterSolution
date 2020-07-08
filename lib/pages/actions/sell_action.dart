import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class sell_action extends StatefulWidget {
  @override
  _sell_actionState createState() => _sell_actionState();
}

class _sell_actionState extends State<sell_action> {
  final _formkey = GlobalKey<FormState>();
  String _userid, _sellcost, _note, _productName;

  Widget _textT() {
    return Text(
      'Sell',
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

  Widget _productId() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: productholder,
        onSaved: (val) => _productName = val,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
            hintText: 'market name and model',
            icon: Icon(
              Icons.local_grocery_store,
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
        onSaved: (newValue) => _note = newValue,
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
    priceholder.clear();
    noteholder.clear();
  }

  void _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      clearTextInput();
      _upload();
    } else {
      print('no !');
    }
  }

  final priceholder = TextEditingController();

  Widget _priceinput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: priceholder,
        onSaved: (val) => _sellcost = val,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'rent cost',
            hintText: 'price will be assigned to your id !  ',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  void _upload() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    final admin = prefs.getString('name') ?? 0;

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "token $token";

    dio
        .post("http://hassanharby2000.pythonanywhere.com/", data: {
          "userid": _userid,
          "price": _sellcost,
          "note": _note,
          "name": _productName,
          "dateTime": DateTime.now(),
          "admin": admin
        })
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    _textT(),
                    _idInput(),
                    _priceinput(),
                    _productId(),
                    _notes(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
