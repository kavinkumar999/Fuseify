part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostingEvent extends PostEvent{}

class UploadingEvent extends PostEvent{
  String base64;
  String imagename;
  String caption;
  bool facebook;
  bool instagram;
  bool twitter;
  bool image;

  UploadingEvent(
    this.base64,
    this.imagename,
    this.caption,
    this.facebook,
    this.instagram,
    this.twitter,
    this.image
  );
}

class PostProvision extends PostEvent{
  int select;
  PostProvision(
    this.select
  );
}