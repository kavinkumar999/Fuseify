import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fuseify/data_layer/data.dart';
import 'package:meta/meta.dart';

part 'stack_event.dart';
part 'stack_state.dart';

class StackBloc extends Bloc<StackEvent, StackState> {
  StackBloc() : super(StackInitial());

  @override
  Stream<StackState> mapEventToState(
    StackEvent event,
  ) async* {
  Endpoint api = new Endpoint();
    // TODO: implement mapEventToState
    if(event is Mediaoption){

      if(event.media == "Facebook"){
          yield Facebook();
      }
      else if(event.media == "Instagram")
      {
        yield Instagram();
      }
      else if(event.media == "Twitter"){
        yield Twitter();
      }
      else{
        yield Allpost();
      }
    }
    if(event is Stackimage){
      List<dynamic> arra =  await api.stack();
      yield Imagelist(arra);
    }
  }
}
