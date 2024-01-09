import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_page_event.dart';
part 'auth_page_state.dart';

class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  AuthPageBloc() : super(AuthPageInitial()) {
    on<ShowLoginPageEvent>(showLoginPageEvent);
    on<ShowRegisterPageEvent>(showRegisterPageEvent);
  }

  FutureOr<void> showLoginPageEvent(
      ShowLoginPageEvent event, Emitter<AuthPageState> emit) {
    emit(ShowLogInPageActionState());
  }

  FutureOr<void> showRegisterPageEvent(
      ShowRegisterPageEvent event, Emitter<AuthPageState> emit) {
    print("register page event triggered");
    emit(ShowRegisterPageActionState());
  }
}
