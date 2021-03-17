part of 'post_provision_bloc.dart';

@immutable
abstract class PostProvisionState {}

class PostProvisionInitial extends PostProvisionState {}

class PostImage extends  PostProvisionState{}

class Posttext extends  PostProvisionState{}
