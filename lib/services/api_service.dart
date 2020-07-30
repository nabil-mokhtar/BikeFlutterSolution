import 'dart:convert';
//import 'dart:html';

import 'package:http/http.dart' as http;

class apiService {
  apiService(this.api_key, this.api_pass);

  String api_key;
  String api_pass;
  Future<String> getAccesToken() async {
    print(api_key);
    print(api_pass);
    final response = await http.post(
        'http://nabilmokhtar.pythonanywhere.com/api-token-auth/', // https://
        //  api.tokenUri().toString(),
        body: jsonEncode(
            <String, String>{'username': api_key, 'password': api_pass}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['token'];
      print(accessToken);
      if (accessToken != null) {
        print(accessToken);
        return accessToken;
      } else {
        print('response status !=200');
      }
    }
  }
}
