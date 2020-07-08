import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class close_rent extends StatefulWidget {
  @override
  _close_rentState createState() => _close_rentState();
}

class _close_rentState extends State<close_rent> {
  final _formkey = GlobalKey<FormState>();
  String _userid, _note, _qr;
  DateTime _date;
  TimeOfDay _time;

  bool _q = false;
  Widget _textT() {
    return Text(
      'Close rent',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _notes() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (newValue) => _note = newValue,
        controller: holder,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'notes',
          hintText: 'descripe issue or discout status ',
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

  Future<String> _qrscanner() async {
    String qr;
    return qr = await scanner.scan();
  }

  Widget _submitbtn() {
    return Center(
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          'Close',
        ),
        onPressed: () {
          _submit();
        },
      ),
    );
  }

  void _submit() {
    if (_formkey.currentState.validate()) {
      _qrscanner();

      if (_qr != null) {
        _date = DateTime.now();
        _time = TimeOfDay.now();
        _formkey.currentState.save();
        clearTextInput();

        print(
            'id:$_userid  ,return Date: $_date ,return time: $_time ,CODE: $_qr ');
      } else {
        print('bike must be selected !');
      }
    } else {
      print('not !');
    }
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
          "notes": _note,
          "QR": _qr,
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
                    _notes(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
