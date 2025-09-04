import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/feature/welcome/presentation/manager/cubit/welcome_cubit.dart';
import 'package:study_box/feature/welcome/presentation/view/widget/welcome_view_body.dart';

class WelcomeViewWrapper extends StatefulWidget {
  const WelcomeViewWrapper({super.key});

  @override
  State<WelcomeViewWrapper> createState() => _WelcomeViewWrapperState();
}

class _WelcomeViewWrapperState extends State<WelcomeViewWrapper>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WelcomeCubit>().initializeAnimations(this);
      context.read<WelcomeCubit>().startAnimations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        if (state is WelcomeNavigateToLogin) {
          context.push(AppRouter.loginView);
        } else if (state is WelcomeNavigateToSignUp) {
          // context.go(AppRouter.signUpView);
        }
      },
      builder: (context, state) {
        final cubit = context.read<WelcomeCubit>();
        if (state is WelcomeInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return WelcomeViewBody(cubit: cubit);
      },
    );
  }
}
