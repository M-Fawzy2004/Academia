import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:study_box/feature/onboarding/presentation/view/widget/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: OnboardingViewBody(),
        ),
      ),
    );
  }
}
