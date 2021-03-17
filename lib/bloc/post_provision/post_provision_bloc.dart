import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_provision_event.dart';
part 'post_provision_state.dart';

class PostProvisionBloc extends Bloc<PostProvisionEvent, PostProvisionState> {
  PostProvisionBloc() : super(PostProvisionInitial());

  @override
  Stream<PostProvisionState> mapEventToState(
    PostProvisionEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is Posttrigger){
      if (event.select == 1){
        yield PostImage();
      }
      else{
        yield Posttext();
      }
    }
  }
}
