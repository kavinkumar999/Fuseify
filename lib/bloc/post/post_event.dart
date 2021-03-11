part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostingEvent extends PostEvent{}

class UploadingEvent extends PostEvent{
  String base64;
  String imagename;
  String caption;

  UploadingEvent(
    this.base64,
    this.imagename,
    this.caption
  );
}
