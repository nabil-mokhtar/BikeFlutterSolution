import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiref_bike/main.dart';
import 'package:shiref_bike/pages/actions.dart';
import 'package:shiref_bike/services/api.dart';
import 'package:shiref_bike/services/api_service.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();
  String _userid, _passw;
  bool _f = false;

  Widget _textT() {
    return Text(
      'Login',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 42, fontWeight: FontWeight.bold),
    );
  }

  final idholder = TextEditingController();
  final holder = TextEditingController();

  Widget _idInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: idholder,
        onSaved: (val) => _userid = val,
        // keyboardType: TextInputType.number,
        // validator: (val) => val.length != 14 ? 'Enter correct ID number' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'UserId',
            hintText: 'requried',
            icon: Icon(
              Icons.face,
              color: Colors.blue[700],
            )),
      ),
    );
  }

  clearTextInput() {
    holder.clear();
    idholder.clear();
  }

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

  Future<void> _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      final api = API(api_key: _userid, api_pass: _passw);
      final apiSer = apiService(api);
      final accesstoken = await apiSer.getAccesToken();

      print('id:$_userid CODE:$_passw token :$accesstoken');

      // if (accesstoken != null) {
      clearTextInput();
      if (accesstoken != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', accesstoken);
        prefs.setString('name', _userid);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return MyApp();
        }));
      } else {
        setState(() {
          this._f = true;
        });
      }

      // }
      // login = true;
    } else {
      print('not !');
    }
  }

  Widget _sbtn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Submit',
              ),
              onPressed: () {
                _submit();
              }),
        ),
      ),
    );
  }

  Widget fail(bool f) {
    if (f == true) {
      return Text(
        'Login failed',
        style: TextStyle(
            color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        '',
        style: TextStyle(
            color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        _textT(),
                        _idInput(),
                        _pass(),
                        _sbtn(),
                        fail(_f)
                        // submitbtn(_formkey, holder, idholder),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
