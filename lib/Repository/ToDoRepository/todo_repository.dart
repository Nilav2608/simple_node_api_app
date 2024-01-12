import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_api_app/Network/configs.dart';

import 'package:simple_api_app/Repository/ToDoRepository/todo_repository.interface.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<Map<String, dynamic>> getUserNotes(String uid) async {
    try {
      var response = await http.post(
        Uri.parse(getAllNotesUrl),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": uid}),
      );
      if (response.statusCode == 200) {
        var results = jsonDecode(response.body);
        return results;
      } else {
        throw "User Id is empty";
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> addNote(
      String uid, String title, String des) async {
    try {
      var response = await http.post(Uri.parse("${url}users/$uid/todos"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({"title": title, "description": des}));
      if (response.statusCode == 201) {
        var results = jsonDecode(response.body);
        return results;
      } else {
        throw "unable to add note";
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> deleteNote(String uid, String noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateNote(String uid, String noteID) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
