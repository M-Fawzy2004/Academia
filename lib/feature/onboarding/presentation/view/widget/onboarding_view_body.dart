import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/feature/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_bottom_section.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_page.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/theme_selector_button.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody>
    with SingleTickerProviderStateMixin {
  late final OnboardingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OnboardingCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeAnimations(this, context);
    });
  }

  @override
  void dispose() {
    cubit.disposeAnimations();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          context.go(AppRouter.welcomeView);
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        // ✅ التحقق من أن الـ animations جاهزة
        if (state is OnboardingInitial ||
            cubit.onboardingData.isEmpty ||
            cubit.fadeAnimation == null ||
            cubit.slideAnimation == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: cubit.pageController,
                      onPageChanged: cubit.onPageChanged,
                      itemCount: cubit.onboardingData.length,
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          data: cubit.onboardingData[index],
                          fadeAnimation:
                              cubit.fadeAnimation!, // ✅ استخدم ! بأمان
                          slideAnimation:
                              cubit.slideAnimation!, // ✅ استخدم ! بأمان
                          currentIndex: cubit.currentIndex,
                          totalPages: cubit.onboardingData.length,
                          onSkip: cubit.skipToEnd,
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: OnboardingBottomSection(
                        currentIndex: cubit.currentIndex,
                        totalPages: cubit.onboardingData.length,
                        onNext: cubit.nextPage,
                        onGetStarted: cubit.getStarted,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.h,
                right: 20.w,
                child: const SafeArea(
                  child: ThemeSelectorButton(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
