import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/widget/forget_pass_view_body.dart';

class ForgetPasswordMainButton extends StatelessWidget {
  final ForgetPasswordStep currentStep;
  final String buttonText;
  final VoidCallback onPressed;

  const ForgetPasswordMainButton({
    super.key,
    required this.currentStep,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return CustomButton(
          text: buttonText,
          onPressed: isLoading ? null : onPressed,
          isLoading: isLoading,
        );
      },
    );
  }
}
