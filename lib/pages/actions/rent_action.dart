import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class rent_action extends StatefulWidget {
  @override
  _rent_actionState createState() => _rent_actionState();
}

class _rent_actionState extends State<rent_action> {
  final _formkey = GlobalKey<FormState>();
  String _userid, _rentcost, _qr;
  DateTime _date;
  TimeOfDay _time;
  bool _switchVal = false;
  bool isEnabled = true;

  bool _t = false, _d = false, _q = false;
  Widget _textT() {
    return Text(
      'Rent',
      style: TextStyle(
          color: Colors.grey[700], fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _dataTime() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: OutlineButton(
            // color: Colors.blue,
            child: Text('Select time'),
            onPressed: isEnabled
                ? () {
                    DateTime now = DateTime.now();

                    showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay(hour: now.hour, minute: now.minute),
                    ).then((TimeOfDay value) {
                      if (value != null) {
                        _time = value;
                        _t = true;
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('${value.format(context)}'),
                          action: SnackBarAction(label: 'Ok', onPressed: () {}),
                        ));
                      }
                    });
                  }
                : null,
          )),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Center(
              child: OutlineButton(
            // color: Colors.blue,
            child: Text(
              'Select date',
            ),
            onPressed: isEnabled
                ? () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025))
                        .then((DateTime value) {
                      if (value != null) {
                        _date = value;
                        _d = true;
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Selected datetime :$value'),
                        ));
                      }
                    });
                  }
                : null,
          )),
        ),
      ],
    );
  }

  clearTextInput() {
    holder.clear();
    idholder.clear();
  }

  Widget _qrscanner() {
    return Center(
        child: OutlineButton(
            // color: Colors.green,
            child: Text('QR'),
            onPressed: () async {
              _qr = await scanner.scan();
            }));
  }

  Widget _switch() {
    return Row(
      children: [
        Text('Open'),
        Center(
          child: Switch(
              value: this._switchVal,
              onChanged: (bool value) {
                setState(() {
                  this._switchVal = value;
                  this.isEnabled = !this.isEnabled;
                });
              }),
        )
      ],
    );
  }

  Widget _submitbtn() {
    return Center(
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          'Submit',
        ),
        onPressed: () {
          _submit();
        },
      ),
    );
  }

  void _submit() {
    if (_formkey.currentState.validate()) {
      if (_switchVal == true) {
        _t = true;
        _d = true;
      }

      if (_t == true && _d == true && _qr != null) {
        _formkey.currentState.save();
        print(
            'id:$_userid , price :$_rentcost ,return Date: $_date ,return time: $_time ,CODE: $_qr ');
        clearTextInput();
      } else {
        print('bike,date and time must be selected !');
      }
    } else {
      print('not !');
    }
  }

  Widget _priceinput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: holder,
        onSaved: (val) => _rentcost = val,
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
                    _switch(),
                    _dataTime(),
                    _qrscanner(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
