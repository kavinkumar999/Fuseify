part of 'stack_bloc.dart';

@immutable
abstract class StackEvent {}

class Mediaoption extends StackEvent{
  String media;
  Mediaoption(
    this.media,
  );
}