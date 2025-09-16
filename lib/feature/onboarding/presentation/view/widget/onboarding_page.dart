import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Column(
      children: [
        Expanded(
          flex: isSmallScreen ? 6 : 7,
          child: Stack(
            children: [
              Positioned(
                top: 80.h,
                right: -40.w,
                child: Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 50.h,
                left: -20.w,
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
              if (currentIndex < totalPages - 1)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10.h,
                  left: 20.w,
                  child: SafeArea(
                    child: TextButton(
                      onPressed: onSkip,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.darkPrimaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        context.tr.onboarding_skip,
                        style: Styles.font12MediumWhiteBold(context),
                      ),
                    ),
                  ),
                ),
              Center(
                child: Container(
                  width: isSmallScreen ? 280.w : 300.w,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 40.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      data.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: isSmallScreen ? 4 : 3,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                          fontSize: isSmallScreen ? 20.sp : 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getTextColor(context),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  heightBox(isSmallScreen ? 15.h : 20.h),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
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
                          maxWidth: 300.w,
                        ),
                        child: Text(
                          data.description,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13.sp : 15.sp,
                            color: const Color(0xFF64748B),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
