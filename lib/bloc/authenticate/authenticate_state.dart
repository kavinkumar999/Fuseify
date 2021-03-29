part of 'authenticate_bloc.dart';

@immutable
abstract class AuthenticateState {}

class AuthenticateInitial extends AuthenticateState {}

class AuthenticateLoading extends AuthenticateState{}

class AuthenticateNullError extends AuthenticateState{}

class AuthenticateAuthenticated  extends AuthenticateState{}

class AuthenticateFailed  extends AuthenticateState{}