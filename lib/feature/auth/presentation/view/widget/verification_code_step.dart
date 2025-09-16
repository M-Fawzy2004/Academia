import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class VerificationCodeStep extends StatelessWidget {
  final TextEditingController verificationCodeController;
  final String? Function(String?)? validator;

  const VerificationCodeStep({
    super.key,
    required this.verificationCodeController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.send_code_with_email,
          style: Styles.font14MediumPrimaryBold(context),
        ),
        heightBox(10),
        Text(
          context.tr.enter_code,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        heightBox(15),
        CustomTextField(
          controller: verificationCodeController,
          hintText: context.tr.verf_code,
          suffixIcon: IconlyLight.shield_done,
          keyboardType: TextInputType.number,
          validator: validator,
        ),
      ],
    );
  }
}
