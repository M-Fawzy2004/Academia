import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_button.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_page_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const OnboardingBottomSection({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OnboardingPageIndicator(
          currentIndex: currentIndex,
          totalPages: totalPages,
        ),
        SizedBox(height: 32.h),
        if (currentIndex == totalPages - 1)
          OnboardingButton(
            text: 'ابدأ الآن',
            onPressed: onGetStarted,
            isPrimary: true,
          )
        else
          OnboardingButton(
            text: 'التالي',
            onPressed: onNext,
            isPrimary: false,
          ),
      ],
    );
  }
}
