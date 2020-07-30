import 'package:flutter/material.dart';

import 'package:shiref_bike/lists/main_list_for_rent.dart';

class edit_bike extends StatelessWidget {
  main_bike k;
  edit_bike(main_bike k) {
    this.k = k;
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController b1, b2, b3, b4, b5, b6;
  String _name_product,
      _descripto,
      _product_cost,
      _rent_costday,
      _rent_costweek,
      _rent_costmonth;
  put() {
    TextEditingController e1 = TextEditingController(text: k.get_description());
    TextEditingController e2 = TextEditingController(text: k.get_model());
    TextEditingController e3 =
        TextEditingController(text: k.get_sell_price().toString());
    TextEditingController e4 =
        TextEditingController(text: k.get_per_day().toString());
    TextEditingController e5 =
        TextEditingController(text: k.get_per_week().toString());
    TextEditingController e6 =
        TextEditingController(text: k.get_per_month().toString());
    b1 = e1;
    b2 = e2;
    b3 = e3;
    b4 = e4;
    b5 = e5;
    b6 = e6;
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b1,
        onSaved: (newValue) => _descripto = newValue.toString(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'discription',
        ),
        maxLines: 2,
      ),
    );
  }

  clearTextInput() {
    b1.clear();
    b2.clear();
    b3.clear();
    b4.clear();
    b5.clear();
    b6.clear();
  }

  Widget _productname() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b2,
        onSaved: (val) => _name_product = val.toString(),
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

  Widget _priceinput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b3,
        onSaved: (val) => _product_cost = val.toString(),
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

  Widget _rentpriceday() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b4,
        onSaved: (val) => _rent_costday = val.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent Cost per day',
            hintText: 'Rent per day',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _rentpriceweek() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b5,
        onSaved: (val) => _rent_costweek = val.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent Cost per week',
            hintText: 'Rent per week',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _rentpricemonth() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: b6,
        onSaved: (val) => _rent_costmonth = val.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabled: !_isEnabled,
            filled: _isEnabled,
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent Cost per month',
            hintText: 'Rent per month',
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
          "Edit",
        ),
        onPressed: () {
          clearTextInput();
        },
      ),
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
                this._switchVal = value;
                this._isEnabled = !this._isEnabled;
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    put();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                    _productname(),
                    _description(),
                    _switch(),
                    _priceinput(),
                    _rentpriceday(),
                    _rentpriceweek(),
                    _rentpricemonth(),
                    _submitbtn(),
                  ],
                ))),
      ),
    );
  }
}
