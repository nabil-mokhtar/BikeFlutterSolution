import 'dart:convert';
//import 'dart:html';

import 'package:shiref_bike/services/api.dart';
import 'package:http/http.dart' as http;

class apiService {
  apiService(this.api);

  final API api;

  Future<String> createBike(String title) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      print("bike added");
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<String> getAccesToken() async {
    print(api.api_key);
    print(api.api_pass);
    final response = await http.post(
        'http://hassanharby2000.pythonanywhere.com/api-token-auth/', // https://
        //  api.tokenUri().toString(),
        body: jsonEncode(<String, String>{
          'username': api.api_key,
          'password': api.api_pass
        }),
        headers: {"Content-Type": "application/json"});
    // how to add password
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['token'];
      if (accessToken != null) {
        return accessToken;
      } else {
        print('response status !=200');
      }
    }
  }
}
