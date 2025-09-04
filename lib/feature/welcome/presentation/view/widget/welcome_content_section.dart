import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/animated_buttons_section.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/title_card.dart';

class WelcomeContentSection extends StatelessWidget {
  const WelcomeContentSection({
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
      flex: isSmallScreen ? 4 : 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          children: [
            TitleCard(
              cubit: cubit,
              isSmallScreen: isSmallScreen,
              isMediumScreen: isMediumScreen,
            ),
            heightBox(isSmallScreen ? 20.h : 30.h),
            AnimatedButtonsSection(
              cubit: cubit,
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
      ),
    );
  }
}
