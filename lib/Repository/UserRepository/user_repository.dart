import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_api_app/Network/configs.dart';
import 'package:simple_api_app/Repository/UserRepository/user_repository.interface.dart';

class UserRepository implements IUserRepository {
  @override
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
      return {"status": false, "message": e.toString()};
    }
  }

  @override
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
      // ignore: empty_catches
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }
}
