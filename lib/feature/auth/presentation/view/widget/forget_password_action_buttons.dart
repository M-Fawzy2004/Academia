import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/auth/presentation/view/widget/forget_pass_view_body.dart';

class ForgetPasswordActionButtons extends StatelessWidget {
  final ForgetPasswordStep currentStep;
  final VoidCallback onResendCode;
  final VoidCallback onGoBack;

  const ForgetPasswordActionButtons({
    super.key,
    required this.currentStep,
    required this.onResendCode,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (currentStep == ForgetPasswordStep.enterVerificationCode) ...[
          heightBox(15),
          TextButton(
            onPressed: onResendCode,
            child: Text(
              context.tr.resend_code,
              style: Styles.font14MediumPrimaryBold(context),
            ),
          ),
        ],
        if (currentStep != ForgetPasswordStep.enterEmail) ...[
          heightBox(15),
          TextButton(
            onPressed: onGoBack,
            child: Text(
              context.tr.back_step,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
