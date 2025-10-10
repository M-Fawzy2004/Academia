part of 'scroll_cubit.dart';

class ScrollState {
  final double scrollProgress; 

  const ScrollState({required this.scrollProgress});

  ScrollState copyWith({double? scrollProgress}) {
    return ScrollState(
      scrollProgress: scrollProgress ?? this.scrollProgress,
    );
  }
}