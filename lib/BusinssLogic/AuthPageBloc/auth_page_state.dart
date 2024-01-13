part of 'auth_page_bloc.dart';

@immutable
sealed class AuthPageState {}

final class AuthPageInitial extends AuthPageState {}

abstract class AuthPageActionState extends AuthPageState{}



class ShowLogInPageActionState extends AuthPageActionState{}



class ShowRegisterPageActionState extends AuthPageActionState{}