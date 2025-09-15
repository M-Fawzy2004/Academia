import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/widget/code_verification_action_buttons.dart'
    show CodeVerificationActionButtons;
import 'package:study_box/feature/auth/presentation/view/widget/email_input_step.dart';
import 'package:study_box/feature/auth/presentation/view/widget/forget_password_header.dart';
import 'package:study_box/feature/auth/presentation/view/widget/forget_password_main_button.dart';
import 'package:study_box/feature/auth/presentation/view/widget/password_reset_success_dialog.dart';
import 'package:study_box/feature/auth/presentation/view/widget/resend_timer_widget.dart';
import 'package:study_box/feature/auth/presentation/view/widget/reset_password_step.dart';
import 'package:study_box/feature/auth/presentation/view/widget/verification_code_step.dart';
import 'dart:async';

enum ForgetPasswordStep {
  enterEmail,
  enterVerificationCode,
  resetPassword,
}

class ForgetPassViewBody extends StatefulWidget {
  const ForgetPassViewBody({super.key});

  @override
  State<ForgetPassViewBody> createState() => _ForgetPassViewBodyState();
}

class _ForgetPassViewBodyState extends State<ForgetPassViewBody> {
  ForgetPasswordStep currentStep = ForgetPasswordStep.enterEmail;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Form keys for validation
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  // Timer for resend functionality
  Timer? _resendTimer;
  int _resendCountdown = 0;
  bool _isResendEnabled = true;

  // Timer duration - 1.5 minutes
  static const int _resendCooldownDuration = 90;

  void _startResendTimer() {
    setState(() {
      _isResendEnabled = false;
      _resendCountdown = _resendCooldownDuration;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void _stopResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _resendCountdown = 0;
      _isResendEnabled = true;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _nextStep() {
    final authCubit = context.read<AuthCubit>();

    switch (currentStep) {
      case ForgetPasswordStep.enterEmail:
        if (_emailFormKey.currentState?.validate() ?? false) {
          authCubit.resetPassword(email: emailController.text.trim());
        }
        break;

      case ForgetPasswordStep.enterVerificationCode:
        if (_codeFormKey.currentState?.validate() ?? false) {
          authCubit.clearError();
          authCubit.verifyPasswordReset(
            token: verificationCodeController.text.trim(),
            email: emailController.text.trim(),
          );
        }
        break;

      case ForgetPasswordStep.resetPassword:
        if (_passwordFormKey.currentState?.validate() ?? false) {
          authCubit.updatePassword(
            password: newPasswordController.text.trim(),
            confirmPassword: confirmPasswordController.text.trim(),
          );
        }
        break;
    }
  }

  void _goBackStep() {
    setState(() {
      switch (currentStep) {
        case ForgetPasswordStep.enterVerificationCode:
          currentStep = ForgetPasswordStep.enterEmail;
          _stopResendTimer();
          break;
        case ForgetPasswordStep.resetPassword:
          currentStep = ForgetPasswordStep.enterVerificationCode;
          break;
        case ForgetPasswordStep.enterEmail:
          break;
      }
    });
    context.read<AuthCubit>().clearError();
  }

  void _resendVerificationCode() {
    if (!_isResendEnabled || emailController.text.trim().isEmpty) return;

    context.read<AuthCubit>().resetPassword(email: emailController.text.trim());
    _startResendTimer();
    verificationCodeController.clear();
  }

  void _showSuccessDialog() {
    _stopResendTimer();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PasswordResetSuccessDialog(),
    );
  }

  void _showErrorSnackBar(String message) {
    CustomSnackBar.showError(context, message);
  }

  void _showSuccessSnackBar(String message) {
    CustomSnackBar.showSuccess(context, message);
  }

  String _getTitle() {
    switch (currentStep) {
      case ForgetPasswordStep.enterEmail:
        return context.tr.forget_reset;
      case ForgetPasswordStep.enterVerificationCode:
        return context.tr.identity_confirmation;
      case ForgetPasswordStep.resetPassword:
        return context.tr.register_confirm_pass;
    }
  }

  String _getButtonText() {
    switch (currentStep) {
      case ForgetPasswordStep.enterEmail:
        return context.tr.enter_verfivcation_code;
      case ForgetPasswordStep.enterVerificationCode:
        return context.tr.confirm_code;
      case ForgetPasswordStep.resetPassword:
        return context.tr.save_pass;
    }
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case ForgetPasswordStep.enterEmail:
        return Form(
          key: _emailFormKey,
          child: EmailInputStep(
            emailController: emailController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.tr.email_required;
              }
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(value.trim())) {
                return context.tr.valid_email_required;
              }
              return null;
            },
          ),
        );

      case ForgetPasswordStep.enterVerificationCode:
        return Column(
          children: [
            Form(
              key: _codeFormKey,
              child: VerificationCodeStep(
                verificationCodeController: verificationCodeController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Verification code is required';
                  }
                  if (value.trim().length < 6) {
                    return context.tr.valid_email_required;
                  }
                  return null;
                },
              ),
            ),
            if (!_isResendEnabled && _resendCountdown > 0)
              ResendTimerWidget(
                remainingTime: _resendCountdown,
                formatTime: _formatTime,
              ),
          ],
        );

      case ForgetPasswordStep.resetPassword:
        return Form(
          key: _passwordFormKey,
          child: ResetPasswordStep(
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            passwordValidator: (value) {
              if (value == null || value.isEmpty) {
                return context.tr.password_required;
              }
              if (value.length < 6) {
                return context.tr.password_6_characters;
              }
              return null;
            },
            confirmPasswordValidator: (value) {
              if (value == null || value.isEmpty) {
                return context.tr.confirm_password_required;
              }
              if (value != newPasswordController.text) {
                return context.tr.passwords_not_match;
              }
              return null;
            },
          ),
        );
    }
  }

  Widget _buildActionButtons() {
    if (currentStep != ForgetPasswordStep.enterVerificationCode) {
      return const SizedBox.shrink();
    }

    return CodeVerificationActionButtons(
      isResendEnabled: _isResendEnabled,
      onResendCode: _resendVerificationCode,
      onGoBack: _goBackStep,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          _showErrorSnackBar(state.message);
        } else if (state is AuthPasswordResetSent) {
          _showSuccessSnackBar(state.message);
          setState(() {
            currentStep = ForgetPasswordStep.enterVerificationCode;
          });
          _startResendTimer();
        } else if (state is AuthEmailVerified) {
          _showSuccessSnackBar(state.message);
          _stopResendTimer();
          setState(() {
            currentStep = ForgetPasswordStep.resetPassword;
          });
        } else if (state is AuthPasswordUpdated) {
          _showSuccessDialog();
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            heightBox(50),
            ForgetPasswordHeader(title: _getTitle()),
            heightBox(20),
            _buildCurrentStep(),
            heightBox(30),
            ForgetPasswordMainButton(
              currentStep: currentStep,
              buttonText: _getButtonText(),
              onPressed: _nextStep,
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
