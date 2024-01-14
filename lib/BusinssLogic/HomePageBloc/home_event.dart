part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialGetNotesEvent extends HomeEvent {
  final String userId;

  HomeInitialGetNotesEvent({required this.userId});
}

class AddNoteEvent extends HomeEvent {
  final String userId;
  final NoteModel note;

  AddNoteEvent({required this.userId, required this.note});
}

class UpdateNoteEvent extends HomeEvent {
  final String userId;
  final NoteModel updatedNote;

  UpdateNoteEvent({required this.userId, required this.updatedNote});
}

class DeleteNoteEvent extends HomeEvent {}
