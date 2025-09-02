import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPages;

  const OnboardingPageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentIndex == index ? 32.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? const Color(0xFF667EEA)
                : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
