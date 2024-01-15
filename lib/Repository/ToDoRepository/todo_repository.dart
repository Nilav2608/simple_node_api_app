import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_api_app/Network/configs.dart';
import 'package:simple_api_app/Repository/ToDoRepository/todo_repository.interface.dart';
import '../../models/note_model.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<List<NoteModel>> getUserNotes(String uid) async {
    try {
      List<NoteModel> currentList = [];
      var response = await http.post(
        Uri.parse(getAllNotesUrl),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": uid}),
      );
      if (response.statusCode == 200) {
        var results = jsonDecode(response.body);
        var fetchedNotes = results['data'];
        for (int i = 0; i < fetchedNotes.length; i++) {
          NoteModel notes = NoteModel.fromJson(fetchedNotes[i]);
          currentList.add(notes);
        }
        return currentList;
      } else {
        throw "User Id is empty";
      }
    } catch (e) {
      return [];
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
  Future<Map<String, dynamic>> deleteNote(String uid, String noteId) async {
    try {
      var response =
          await http.delete(Uri.parse("${url}users/$uid/deleteNote/$noteId"));

      var results = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return results;
      } else if (response.statusCode == 400) {
        return results;
      } else {
        throw "An internal Eroor occurd";
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  @override
  Future<Map<String, dynamic>> updateNote(
      String uid, NoteModel updatedNote) async {
    try {
      var formatedBody = jsonEncode(NoteModel(
              title: updatedNote.title,
              description: updatedNote.description,
              date: updatedNote.date,
              completed: false)
          .toJson());
      var response = await http.put(
          Uri.parse("${url}users/$uid/updateNote/${updatedNote.id}"),
          headers: {"content-type": "application/json"},
          body: formatedBody);
      if (response.statusCode == 200) {
        var results = jsonDecode(response.body);
        return results;
      } else if (response.statusCode == 400) {
        var results = jsonDecode(response.body);
        return results;
      } else if (response.statusCode == 404) {
        var results = jsonDecode(response.body);
        return results;
      } else {
        throw "Error occurd";
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }
}
