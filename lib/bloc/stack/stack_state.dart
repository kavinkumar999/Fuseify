part of 'stack_bloc.dart';

@immutable
abstract class StackState {}

class StackInitial extends StackState {}

class Allpost extends StackState{}


class Facebook extends StackState{}

class Instagram extends StackState{}

class Twitter extends StackState{}

class Imagelist extends StackState{
  List<dynamic> a;

  Imagelist(this.a);
}
