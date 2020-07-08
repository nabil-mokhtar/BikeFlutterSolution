import 'package:flutter/foundation.dart';

class API {
  API({@required this.api_key, @required this.api_pass});

  final String api_key;
  final String api_pass;

  static final String host = 'http://hassanharby2000.pythonanywhere.com/';
  // static final int port = 443;

  Uri tokenUri() {
    Uri(
      // scheme: 'http',
      host: host,
      // port: port,
      path: 'api-token-auth/',
      // queryParameters: {},
    );
  }
}
