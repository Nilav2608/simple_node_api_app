import 'package:flutter/material.dart';
import 'package:simple_api_app/BusinssLogic/HomePageBloc/home_bloc.dart';
import 'package:simple_api_app/models/note_model.dart';

class AddOrUpdateNote extends StatefulWidget {
  final String? userId;
  final HomeBloc bloc;
  final NoteModel? initialNote;
  const AddOrUpdateNote(
      {super.key, required this.userId, required this.bloc, this.initialNote});

  @override
  State<AddOrUpdateNote> createState() => _AddOrUpdateNoteState();
}

class _AddOrUpdateNoteState extends State<AddOrUpdateNote> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.initialNote?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.initialNote?.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdateMode = widget.initialNote != null;
    return Scaffold(
      appBar: AppBar(title: Text(isUpdateMode ? 'Update Note' : "Add Note")),
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
                controller: descriptionController,
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
              if (isUpdateMode) {
                widget.bloc.add(UpdateNoteEvent(
                    userId: widget.userId ?? '',
                    updatedNote: widget.initialNote!.copyWith(
                        id: widget.initialNote!.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        completed: widget.initialNote!.completed,
                        date: DateTime.now().toString())));
                Navigator.of(context).pop();    
              } else {
                widget.bloc.add(AddNoteEvent(
                    userId: widget.userId.toString(),
                    note: NoteModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        completed: false,
                        date: DateTime.now().toString())));
                Navigator.of(context).pop();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(isUpdateMode ? 'Update' : "Add note"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
