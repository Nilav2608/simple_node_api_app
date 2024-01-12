abstract class ITodoRepository {
  Future<Map<String, dynamic>> getUserNotes(String uid);
  Future<Map<String, dynamic>> addNote(String uid,String title,String des);
  Future<Map<String, dynamic>> updateNote(String uid,String noteID);
  Future<Map<String, dynamic>> deleteNote(String uid,String noteId);
}
