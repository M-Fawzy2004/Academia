import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final PageController pageController = PageController();
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  List<OnboardingModel> onboardingData = [];
  int currentIndex = 0;

  void initializeAnimations(
      TickerProvider tickerProvider, BuildContext context) {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: tickerProvider,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    ));

    // Build onboarding data with localized strings
    _buildOnboardingData(context);

    animationController.forward();
    emit(OnboardingAnimationInitialized());
  }

  void _buildOnboardingData(BuildContext context) {
    onboardingData = [
      OnboardingModel(
        image: Assets.imagesJpgOnboardingImage1,
        title: context.tr.onboarding_title1,
        description: context.tr.onboarding_desc1,
      ),
      OnboardingModel(
        image: Assets.imagesJpgOnboardingImage2,
        title: context.tr.onboarding_title2,
        description: context.tr.onboarding_desc2,
      ),
      OnboardingModel(
        image: Assets.imagesJpgOnboardingImage3,
        title: context.tr.onboarding_title3,
        description: context.tr.onboarding_desc3,
      ),
    ];
  }

  void onPageChanged(int index) {
    currentIndex = index;
    animationController.reset();
    animationController.forward();
    emit(OnboardingPageChanged(index));
  }

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToEnd() {
    pageController.animateToPage(
      onboardingData.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void getStarted() {
    emit(OnboardingCompleted());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    animationController.dispose();
    return super.close();
  }
}
