import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());

  late AnimationController slideController;
  late AnimationController fadeController;
  late AnimationController buttonController;

  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;
  late Animation<double> titleFadeAnimation;
  late Animation<double> descriptionFadeAnimation;
  late Animation<Offset> buttonSlideAnimation;
  late Animation<double> buttonFadeAnimation;

  void initializeAnimations(TickerProvider tickerProvider) {
    // Main slide animation controller
    slideController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: tickerProvider,
    );

    // Fade animation controller
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: tickerProvider,
    );

    // Button animation controller
    buttonController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: tickerProvider,
    );

    // Slide up animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideController,
      curve: Curves.easeOutQuart,
    ));

    // Fade animation
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
    ));

    // Title fade animation
    titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    // Description fade animation
    descriptionFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    // Button slide animation
    buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeOutBack,
    ));

    // Button fade animation
    buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeInOut,
    ));

    emit(WelcomeAnimationsInitialized());
  }

  void startAnimations() async {
    // Start all animations with smoother delays
    slideController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 1000));
    buttonController.forward();

    emit(WelcomeAnimationsStarted());
  }

  void navigateToLogin() {
    emit(WelcomeNavigateToLogin());
  }

  void navigateToSignUp() {
    emit(WelcomeNavigateToSignUp());
  }

  @override
  Future<void> close() {
    slideController.dispose();
    fadeController.dispose();
    buttonController.dispose();
    return super.close();
  }
}
