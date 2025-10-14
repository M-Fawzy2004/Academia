import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dialog_animation_state.dart';

class DialogAnimationCubit extends Cubit<DialogAnimationState> {
  DialogAnimationCubit({required TickerProvider vsync})
      : super(DialogAnimationState.initial(vsync)) {
    _initialize();
  }

  void _initialize() {
    state.animationController.forward();
  }

  @override
  Future<void> close() {
    state.animationController.dispose();
    return super.close();
  }
}
