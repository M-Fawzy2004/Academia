import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/view/verf_email_view.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: context.tr.register_username,
          suffixIcon: IconlyLight.profile,
        ),
        heightBox(15),
        CustomTextField(
          hintText: context.tr.login_email,
          suffixIcon: IconlyLight.message,
        ),
        heightBox(15),
        CustomTextField(
          hintText: context.tr.login_pass,
          obscureText: true,
        ),
        heightBox(15),
        CustomTextField(
          hintText: context.tr.register_confirm_pass,
          obscureText: true,
        ),
        heightBox(35),
        CustomButton(
          text: context.tr.login_register,
          onPressed: () {
            context.navigateWithSlideTransition(const VerfEmailView());
          },
        ),
      ],
    );
  }
}
