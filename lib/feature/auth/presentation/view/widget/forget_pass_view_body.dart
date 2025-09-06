import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/auth/presentation/view/widget/email_input_step.dart';
import 'package:study_box/feature/auth/presentation/view/widget/forget_password_action_buttons.dart';
import 'package:study_box/feature/auth/presentation/view/widget/reset_password_step.dart';
import 'package:study_box/feature/auth/presentation/view/widget/verification_code_step.dart';

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

  // Methods
  void _nextStep() {
    setState(() {
      switch (currentStep) {
        case ForgetPasswordStep.enterEmail:
          currentStep = ForgetPasswordStep.enterVerificationCode;
          break;
        case ForgetPasswordStep.enterVerificationCode:
          currentStep = ForgetPasswordStep.resetPassword;
          break;
        case ForgetPasswordStep.resetPassword:
          _showSuccessDialog();
          break;
      }
    });
  }

  void _goBackStep() {
    setState(() {
      switch (currentStep) {
        case ForgetPasswordStep.enterVerificationCode:
          currentStep = ForgetPasswordStep.enterEmail;
          break;
        case ForgetPasswordStep.resetPassword:
          currentStep = ForgetPasswordStep.enterVerificationCode;
          break;
        case ForgetPasswordStep.enterEmail:
          break;
      }
    });
  }

  void _resendVerificationCode() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('تم إرسال رمز التحقق مرة أخرى')),
    // );
  }

  void _showSuccessDialog() {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('نجح!'),
    //     content: const Text('تم تغيير كلمة المرور بنجاح'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: const Text('موافق'),
    //       ),
    //     ],
    //   ),
    // );
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
        return EmailInputStep(emailController: emailController);

      case ForgetPasswordStep.enterVerificationCode:
        return VerificationCodeStep(
          verificationCodeController: verificationCodeController,
        );

      case ForgetPasswordStep.resetPassword:
        return ResetPasswordStep(
          newPasswordController: newPasswordController,
          confirmPasswordController: confirmPasswordController,
        );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(50),
          Text(
            _getTitle(),
            style: Styles.font18MediumPrimaryBold(context),
          ),
          heightBox(20),
          Center(
            child: Image.asset(
              Assets.imagesJpgForgetPassImage,
              height: 200.h,
              width: 200.w,
            ),
          ),
          heightBox(20),
          _buildCurrentStep(),
          heightBox(30),
          CustomButton(
            text: _getButtonText(),
            onPressed: _nextStep,
          ),
          ForgetPasswordActionButtons(
            currentStep: currentStep,
            onResendCode: _resendVerificationCode,
            onGoBack: _goBackStep,
          ),
        ],
      ),
    );
  }
}
