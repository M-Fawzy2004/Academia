import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({
    super.key,
    required this.cubit,
    required this.isSmallScreen,
    required this.isMediumScreen,
  });

  final WelcomeCubit cubit;
  final bool isSmallScreen;
  final bool isMediumScreen;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: cubit.titleFadeAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr.welcome_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen
                  ? 18.sp
                  : isMediumScreen
                      ? 20.sp
                      : 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
          heightBox(isSmallScreen ? 8.h : 12.h),
          FadeTransition(
            opacity: cubit.descriptionFadeAnimation,
            child: Text(
              context.tr.welcome_desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 14.sp : 16.sp,
                color: const Color(0xFF64748B),
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
