import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/welcome_content_section.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/welcome_header_image.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key, required this.cubit});

  final WelcomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: cubit.slideAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isSmallScreen = constraints.maxHeight < 600.h;
              bool isMediumScreen = constraints.maxHeight < 800.h &&
                  constraints.maxHeight >= MediaQuery.of(context).size.height.h;
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      heightBox(isSmallScreen ? 10.h : 15.h),
                      WelcomeHeaderImage(
                        isSmallScreen: isSmallScreen,
                        cubit: cubit,
                        isMediumScreen: isMediumScreen,
                      ),
                      heightBox(isSmallScreen ? 15.h : 25.h),
                      WelcomeContentSection(
                        isSmallScreen: isSmallScreen,
                        cubit: cubit,
                        isMediumScreen: isMediumScreen,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
