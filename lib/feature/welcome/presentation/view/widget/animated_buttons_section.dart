import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';

class AnimatedButtonsSection extends StatelessWidget {
  const AnimatedButtonsSection({
    super.key,
    required this.cubit,
    required this.isSmallScreen,
  });

  final WelcomeCubit cubit;
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: cubit.buttonSlideAnimation,
      child: FadeTransition(
        opacity: cubit.buttonFadeAnimation,
        child: Container(
          constraints: BoxConstraints(maxWidth: 380.w),
          child: Column(
            children: [
              CustomButton(
                text: context.tr.welcome_button_login,
                onPressed: cubit.navigateToLogin,
              ),
              heightBox(isSmallScreen ? 10.h : 15.h),
              CustomButton(
                text: context.tr.welcome_button_register,
                onPressed: cubit.navigateToSignUp,
                backgroundColor: AppColors.secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
