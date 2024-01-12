import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api_app/Repository/ToDoRepository/todo_repository.dart';
import 'package:simple_api_app/models/note_model.dart';

class HomePage extends StatefulWidget {
  final String mytoken;
  const HomePage({super.key, required this.mytoken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  String? userId = "";

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<NoteModel> notes = [];
  var orginalResponse = [];

  @override
  void initState() {
    initPrefs();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.mytoken);
    userId = jwtDecodedToken['_id'];
    getNote(userId??'');
    super.initState();
  }

  mappNotes(List items) {
    for (var e in items) {
      notes.add(NoteModel(
          id: e['_id'],
          title: e['title'],
          description: e['description'],
          completed: e['completed'],
          date: e['createdAt']));
    }
  }

  getNote(String id) async {
    var response = await TodoRepository().getUserNotes(id);
    if (response['status']) {
      var noteData = response['data'];
      mappNotes(noteData);
      setState(() {});
    }
  }

  logOut() {
    Navigator.of(context).pushReplacementNamed('/landingPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await prefs.remove('token');
                logOut();
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          var note = notes[index];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              title: Text(note.title ?? ""),
              subtitle: Text(note.description ?? ""),
            ),
          );
        },
      ),
    );
  }
}
