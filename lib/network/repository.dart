import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_api_app/network/configs.dart';

class ApiRepository {
  registerUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var data = {"email": email, "password": password};

        var response = await http.post(Uri.parse(registerationUrl),
            headers: {"content-Type": "application/json"},
            body: json.encode(data));

        print(response);
      }
    } catch (e) {
      print(e);
    }
  }
}
