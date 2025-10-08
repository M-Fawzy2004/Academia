import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final PageController pageController = PageController();
  AnimationController? animationController;
  Animation<double>? fadeAnimation;
  Animation<Offset>? slideAnimation;

  List<OnboardingModel> onboardingData = [];
  int currentIndex = 0;

  void initializeAnimations(
      TickerProvider tickerProvider, BuildContext context) {
    // ✅ تأكد من التخلص من الـ controller القديم أولاً
    animationController?.dispose();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: tickerProvider,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.easeInOut),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOutBack,
    ));

    _buildOnboardingData(context);
    animationController?.forward();
    emit(OnboardingAnimationInitialized());
  }

  // ✅ دالة منفصلة للتخلص من الـ animations
  void disposeAnimations() {
    animationController?.dispose();
    animationController = null;
    fadeAnimation = null;
    slideAnimation = null;
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
    animationController?.reset();
    animationController?.forward();
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
    disposeAnimations();
    pageController.dispose();
    return super.close();
  }
}
