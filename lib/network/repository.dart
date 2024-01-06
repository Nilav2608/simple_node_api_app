import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_api_app/network/configs.dart';

class ApiRepository {
  Future registerUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var data = {"email": email, "password": password};

        var response = await http.post(Uri.parse(registerationUrl),
            headers: {"content-Type": "application/json"},
            body: json.encode(data));
        var results = jsonDecode(response.body);

        return results;
      } else {
        throw "someting went wrong";
      }
    } catch (e) {
      return e;
    }
  }

  Future loginWithEmailAndPawword(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var data = {"email": email, "password": password};

        var response = await http.post(Uri.parse(loginUrl),
            headers: {"content-type": "application/json"},
            body: jsonEncode(data));
        var results = jsonDecode(response.body);
        return results;
      }
    } catch (e) {}
  }
}
