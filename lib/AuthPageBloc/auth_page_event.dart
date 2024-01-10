part of 'auth_page_bloc.dart';

@immutable
sealed class AuthPageEvent {}

class AuthPaegInitalEvent extends AuthPageEvent{}

class ShowLoginPageEvent extends AuthPageEvent{}
class ShowRegisterPageEvent extends AuthPageEvent{}