import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/onboarding/data/model/onboarding_model.dart';

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({super.key, required this.data});

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320.w,
        height: 320.h,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 90.h,
        ),
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            data.image,
            fit: BoxFit.cover,
            width: 320.w,
            height: 320.h,
          ),
        ),
      ),
    );
  }
}
