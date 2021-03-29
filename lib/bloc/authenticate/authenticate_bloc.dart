import 'dart:async' ;

import 'package:bloc/bloc.dart';
import 'package:fuseify/data_layer/data.dart';
import 'package:meta/meta.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc() : super(AuthenticateInitial());
   Endpoint api = new Endpoint();
  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async* {
    if (event is LoginInitiated){
      yield AuthenticateLoading();
      final bool status = await api.loginstatus(event.api,event.secret) ;
      if(status == true){
        yield AuthenticateAuthenticated();
      }
      else{
        yield AuthenticateFailed();
      }
    }
    if (event is LoginFailedNull){
      yield AuthenticateNullError();
    }
    if(event is LoginFailed){
      yield AuthenticateFailed();
    }
  }
}

