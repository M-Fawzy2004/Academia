import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';

class WelcomeHeaderImage extends StatelessWidget {
  const WelcomeHeaderImage({
    super.key,
    required this.isSmallScreen,
    required this.cubit,
    required this.isMediumScreen,
  });

  final bool isSmallScreen;
  final WelcomeCubit cubit;
  final bool isMediumScreen;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: isSmallScreen ? 2 : 3,
      child: FadeTransition(
        opacity: cubit.fadeAnimation,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: isSmallScreen
                ? 250.h
                : isMediumScreen
                    ? 300.h
                    : 350.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  Assets.imagesPngWelcomeViewImage,
                  height: isSmallScreen
                      ? 200.h
                      : isMediumScreen
                          ? 350.h
                          : 400.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
