part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class StartPost extends PostState{}

class PostingImage extends PostState{}

class Posted extends PostState{}

class Uploadstarted extends PostState{}

class Uploading extends PostState{}

class Uploaded extends PostState{}