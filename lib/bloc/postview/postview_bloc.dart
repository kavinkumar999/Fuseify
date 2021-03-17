import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'postview_event.dart';
part 'postview_state.dart';

class PostviewBloc extends Bloc<PostviewEvent, PostviewState> {
  PostviewBloc() : super(PostviewInitial());

  @override
  Stream<PostviewState> mapEventToState(
    PostviewEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
