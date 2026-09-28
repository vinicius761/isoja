import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProviderJava extends GetConnect {
  @override
  void onInit() {
    baseUrl = dotenv.env['BASE_URL_JAVA'];

    final username = dotenv.env['USER'];
    final password = dotenv.env['PASS'];

    allowAutoSignedCert = true;

    httpClient.addRequestModifier<dynamic>((request) {
      final basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      request.headers['Authorization'] = basicAuth;
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    super.onInit();
  }
}
