part of 'post_provision_bloc.dart';

@immutable
abstract class PostProvisionEvent {}


class Posttrigger extends  PostProvisionEvent{
  int select;
  Posttrigger(
    this.select
  );
}