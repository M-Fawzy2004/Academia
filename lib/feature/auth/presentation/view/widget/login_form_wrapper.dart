import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/widget/login_form.dart';

class LoginFormWrapper extends StatelessWidget {
  const LoginFormWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.showError(context, state.message);
          context.read<AuthCubit>().clearError();
        }

        if (state is AuthAuthenticated) {
          context.go(AppRouter.mainView);
          CustomSnackBar.showSuccess(
            context,
            context.tr.successfully_logged_in,
          );
        }
      },
      builder: (context, state) {
        return LoginForm(state: state);
      },
    );
  }
}
