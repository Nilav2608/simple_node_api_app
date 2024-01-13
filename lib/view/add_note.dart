import 'package:flutter/material.dart';
import 'package:simple_api_app/BusinssLogic/HomePageBloc/home_bloc.dart';
import 'package:simple_api_app/models/note_model.dart';

class AddNotePage extends StatelessWidget {
  final String? userId;
  final HomeBloc bloc;
  const AddNotePage({super.key, required this.userId, required this.bloc});
  @override
  Widget build(BuildContext context) {
    showSnackBar(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Create')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: contentController,
                minLines: 5,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                bloc.add(AddNoteEvent(
                    userId: userId.toString(),
                    note: NoteModel(
                        title: titleController.text,
                        description: contentController.text,
                        completed: false,
                        date: DateTime.now().toString())));
                Navigator.of(context).pop();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text('Create'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
