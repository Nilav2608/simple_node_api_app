part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFetchingSuccessState extends HomeState {
  final List<NoteModel> notesList;

  HomeFetchingSuccessState({required this.notesList});
}

class HomeLoadedErrorState extends HomeActionState {
  final String errorMessage;

  HomeLoadedErrorState({required this.errorMessage});
}

class HomeNavigateToAddNotePage extends HomeActionState {}

class HomeNavigateToEditNotePage extends HomeActionState {}
