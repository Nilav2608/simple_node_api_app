import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_api_app/Repository/ToDoRepository/todo_repository.dart';
import 'package:simple_api_app/models/note_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialGetNotesEvent>(homeInitialGetNotesEvent);
    on<AddNoteEvent>(addNoteEvent);
    on<UpdateNoteEvent>(updateNoteEvent);
  }

  FutureOr<void> homeInitialGetNotesEvent(
      HomeInitialGetNotesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    var notesData = await TodoRepository().getUserNotes(event.userId);
    emit(HomeFetchingSuccessState(notesList: notesData));
  }

  FutureOr<void> addNoteEvent(
      AddNoteEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    if (event.userId.isNotEmpty) {
      var apiResults = await TodoRepository().addNote(event.userId,
          event.note.title.toString(), event.note.description.toString());
      if (apiResults["status"]) {
        var notesData = await TodoRepository().getUserNotes(event.userId);
        emit(HomeFetchingSuccessState(notesList: notesData));
      }
    }
  }

  FutureOr<void> updateNoteEvent(
      UpdateNoteEvent event, Emitter<HomeState> emit) async {
    print("event triggered");
    if (event.userId.isNotEmpty) {
      
      var apiResults =
          await TodoRepository().updateNote(event.userId, event.updatedNote);
      print(apiResults);
      if (apiResults['status']) {
        var notesData = await TodoRepository().getUserNotes(event.userId);
        emit(HomeFetchingSuccessState(notesList: notesData));
      }
    }
  }
}
