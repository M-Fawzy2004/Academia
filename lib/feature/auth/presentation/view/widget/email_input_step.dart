import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class EmailInputStep extends StatelessWidget {
  final TextEditingController emailController;

  const EmailInputStep({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'من فضلك ادخل بريدك الالكتروني',
            style: Styles.font14MediumPrimaryBold(context),
          ),
        ),
        heightBox(15),
        CustomTextField(
          controller: emailController,
          hintText: context.tr.login_email,
          suffixIcon: IconlyLight.message,
        ),
      ],
    );
  }
}
