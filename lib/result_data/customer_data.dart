import 'package:flutter/material.dart';
import 'package:shiref_bike/result_data/rented_bike_data.dart';

class data_bike_customer extends StatelessWidget {
  int id;
  String name;
  String image;

  data_bike_customer(int id, String name, String image) {
    this.id = id;
    this.name = name;
    this.image = image;
  }

  final _formkey = GlobalKey<FormState>();

  Widget _namee() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: name),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _idd() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController(text: id.toString()),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'National id',
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _imagee() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Image.network(image),
    );
  }

  final idholder = TextEditingController();
  final holder = TextEditingController();
  final rentholder = TextEditingController();
  final priceholder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("customer data")),
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
                    _idd(),
                    _namee(),
                  ],
                ))),
      ),
    );
  }
}
