part of 'dialog_animation_cubit.dart';

class DialogAnimationState {
  final AnimationController animationController;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  DialogAnimationState({
    required this.animationController,
    required this.scaleAnimation,
    required this.fadeAnimation,
  });

  factory DialogAnimationState.initial(TickerProvider vsync) {
    final controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    final scale = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    final fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    return DialogAnimationState(
      animationController: controller,
      scaleAnimation: scale,
      fadeAnimation: fade,
    );
  }
}
