import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is UploadingEvent){
      yield Uploadstarted();
      yield Uploading();
      yield Uploaded();
    }
    if(event is PostingEvent){
      yield StartPost();
      yield PostingImage();
      yield Posted();
    }
  }
}
