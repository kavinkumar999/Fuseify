part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostingEvent extends PostEvent {}

class UploadingEvent extends PostEvent {
  String base64;
  String imagename;
  String caption;
  bool facebook;
  bool instagram;
  bool twitter;
  bool image;
  bool futuretime;
  int hrs;

  UploadingEvent(this.base64, this.imagename, this.caption, this.facebook,
      this.instagram, this.twitter, this.image,this.futuretime,this.hrs);
}

class PostProvision extends PostEvent {
  int select;
  PostProvision(this.select);
}

class Futurepost extends PostEvent{
  bool option;
  Futurepost(this.option);
}