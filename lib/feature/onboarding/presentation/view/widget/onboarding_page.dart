import 'package:flutter/material.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/decorative_shapes.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_image.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_skip_button.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_text.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel data;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onSkip;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.currentIndex,
    required this.totalPages,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              // Decorative Background Shapes
              const DecorativeShapes(),

              // Skip Button
              if (currentIndex < totalPages - 1)
                OnboardingSkipButton(
                  onSkip: onSkip,
                ),

              // Image with fixed size
              OnboardingImage(data: data),
            ],
          ),
        ),

        // Text Section
        OnboardingText(
          slideAnimation: slideAnimation,
          fadeAnimation: fadeAnimation,
          data: data,
        ),
      ],
    );
  }
}
