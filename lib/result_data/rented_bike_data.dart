import 'package:flutter/material.dart';
import 'package:shiref_bike/add_types/add_user.dart';
import 'package:shiref_bike/lists/main_list_for_rent.dart';
import 'package:shiref_bike/result_data/customer_data.dart';
import 'package:shiref_bike/widgets/shared.dart';

import 'package:shiref_bike/lists/rented_list.dart';
import 'package:shiref_bike/pages/home.dart';
import '../main.dart';

class data_rented_bike extends StatelessWidget {
  final main_bike k;

  data_rented_bike(this.k);

  final _formkey = GlobalKey<FormState>();

  Widget _description() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_description()),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'discription',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _rent_price_forday() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_per_day().toString()),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'rent price for day',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _imagee() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Image.network(k.get_image()),
    );
  }

  Widget _rent_price_forweek() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_per_week().toString()),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'rent price for week',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _rent_price_formonth() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_per_month().toString()),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'rent price for month',
        ),
        maxLines: 2,
      ),
    );
  }

  final idholder = TextEditingController();
  final holder = TextEditingController();
  final rentholder = TextEditingController();
  final priceholder = TextEditingController();

  Widget _productname() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_model()),
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
        enabled: false,
        controller: TextEditingController(text: k.get_sell_price().toString()),
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

  Widget _rentprice() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: k.get_sell_price().toString()),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixText: 'EGP',
            suffixStyle: TextStyle(color: Colors.green),
            border: OutlineInputBorder(),
            labelText: 'Rent Cost',
            hintText: 'Rent per month',
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _show_data_customer(context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: RaisedButton(
          color: Colors.blue,
          child: Text('show customer data'),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return data_bike_customer(12112, "sasasd", k.get_image());
            }));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("data rened bike")),
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
                    _imagee(),
                    _productname(),
                    _description(),
                    _priceinput(),
                    _rent_price_forday(),
                    _rent_price_forweek(),
                    _rent_price_formonth(),
                    _show_data_customer(context),
                  ],
                ))),
      ),
    );
  }
}
