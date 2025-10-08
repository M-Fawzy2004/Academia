import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.data,
  });

  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextColor(context),
                    height: 1.3,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            heightBox(18),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: fadeAnimation,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              )),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: fadeAnimation,
                    curve: const Interval(
                      0.3,
                      1.0,
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 320.w,
                  ),
                  child: Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF64748B),
                      height: 1.6,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
