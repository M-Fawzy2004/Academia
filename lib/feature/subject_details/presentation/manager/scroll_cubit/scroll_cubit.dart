import 'package:bloc/bloc.dart';
part 'scroll_state.dart';

class ScrollCubit extends Cubit<ScrollState> {
  ScrollCubit() : super(const ScrollState(scrollProgress: 1.0));

  void updateScrollProgress(double progress) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    if (state.scrollProgress != clampedProgress) {
      emit(state.copyWith(scrollProgress: clampedProgress));
    }
  }
}