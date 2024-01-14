import 'package:simple_api_app/models/note_model.dart';

abstract class ITodoRepository {
  Future<List<NoteModel>> getUserNotes(String uid);
  Future<Map<String, dynamic>> addNote(String uid,String title,String des);
  Future<Map<String, dynamic>> updateNote(String uid,NoteModel updatedNote);
  Future<Map<String, dynamic>> deleteNote(String uid,String noteId);
}
