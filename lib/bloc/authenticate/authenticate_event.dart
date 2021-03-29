part of 'authenticate_bloc.dart';

@immutable
abstract class AuthenticateEvent {}


class LoginInitiated extends AuthenticateEvent{
  final String api;
  final String secret;
  LoginInitiated(
    this.api,this.secret
  );
}

class LoginFailedNull extends AuthenticateEvent{}

class LoginFailed extends AuthenticateEvent{}

class Logout extends AuthenticateEvent{}
