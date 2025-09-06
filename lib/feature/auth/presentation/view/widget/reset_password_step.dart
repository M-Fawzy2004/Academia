import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class ResetPasswordStep extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const ResetPasswordStep({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  State<ResetPasswordStep> createState() => _ResetPasswordStepState();
}

class _ResetPasswordStepState extends State<ResetPasswordStep> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            context.tr.enter_new_pass,
            style: Styles.font14MediumPrimaryBold(context),
          ),
        ),
        heightBox(15),
        CustomTextField(
          controller: widget.newPasswordController,
          hintText: context.tr.new_pass,
          suffixIcon: isPasswordVisible ? IconlyLight.show : IconlyLight.hide,
          obscureText: !isPasswordVisible,
        ),
        heightBox(15),
        CustomTextField(
          controller: widget.confirmPasswordController,
          hintText: context.tr.register_confirm_pass,
          suffixIcon:
              isConfirmPasswordVisible ? IconlyLight.show : IconlyLight.hide,
          obscureText: !isConfirmPasswordVisible,
        ),
        heightBox(10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            context.tr.pass_at_least,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
