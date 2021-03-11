import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fuseify/data_layer/data.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());
  Endpoint api = new Endpoint();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is UploadingEvent) {
      print("started");
      yield Uploadstarted();
      String docName =  await api.create_record(event.caption) ;
      print(docName);
      if (docName == "error") {
        yield Uploadingstop();
      } else {
         await api.uploaddata(event.base64,event.imagename,docName);
        await api.update_to_field(docName, event.imagename);
        yield Uploading();
        yield Uploaded();
      }
    }
    if (event is PostingEvent) {
      yield StartPost();
      yield Postingstop();
      yield PostingImage();
      yield Posted();
    }
  }
}
