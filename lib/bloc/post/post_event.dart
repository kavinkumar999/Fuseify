part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostingEvent extends PostEvent{}

class UploadingEvent extends PostEvent{}
