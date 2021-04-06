import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      yield Uploadstarted();
      String docName = await api.create_record(
          event.caption, event.facebook, event.instagram, event.twitter,event.futuretime,event.hrs.toString());
      if (docName == "error") {
         Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
        yield Uploadingstop();
      } else {
        if (event.image) {
          yield Uploading();
          await api.uploaddata(event.base64, event.imagename, docName);
          await api.update_to_field(docName, event.imagename);
          yield Uploaded();
        }
        await  api.post(docName);
        Fluttertoast.showToast(
        msg: "Posted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
      }
    }
    if (event is PostingEvent) {
      yield StartPost();
      yield Postingstop();
      yield PostingImage();
      yield Posted();
    }
    if (event is PostProvision) {
      if (event.select == 1) {
        yield Postimage();
      } else {
        yield Posttext();
      }
    }
    if(event is Futurepost){
      bool answer = event.option ? false : true;
      yield Futureselection(answer);
    }
  }
}
