import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/custom_flushbar.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/widget/register_form.dart';

class RegisterFormWrapper extends StatefulWidget {
  const RegisterFormWrapper({super.key});

  @override
  State<RegisterFormWrapper> createState() => _RegisterFormWrapperState();
}

class _RegisterFormWrapperState extends State<RegisterFormWrapper> {
  String? userEmail;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomFlushbar.showError(context, state.message);
          context.read<AuthCubit>().clearError();
        }

        if (state is AuthSignUpSuccess) {
          userEmail = state.user.email;

          if (userEmail != null && userEmail!.isNotEmpty) {
            context.go(
                '${AppRouter.verfEmailView}?email=${Uri.encodeComponent(userEmail!)}');
          } else {
            context.go(AppRouter.verfEmailView);
            CustomFlushbar.showError(
              context,
              'Warning: Email not found in registration response',
            );
          }
        }

        if (state is AuthAuthenticated) {
          context.go(AppRouter.homeView);
        }
      },
      builder: (context, state) => RegisterForm(
        state: state,
        onEmailChanged: (email) => userEmail = email,
      ),
    );
  }
}
