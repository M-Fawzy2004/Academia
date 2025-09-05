import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/view/forget_pass_view.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: context.tr.login_email,
          suffixIcon: IconlyLight.message,
        ),
        heightBox(15),
        CustomTextField(
          hintText: context.tr.login_pass,
          obscureText: true,
        ),
        heightBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                context.navigateWithSlideTransition(const ForgetPassView());
              },
              child: Text(
                context.tr.login_forgot,
                style: Styles.font14MediumPrimaryBold(context),
              ),
            ),
          ],
        ),
        heightBox(35),
        CustomButton(
          text: context.tr.login_button,
          onPressed: () {},
        ),
      ],
    );
  }
}
