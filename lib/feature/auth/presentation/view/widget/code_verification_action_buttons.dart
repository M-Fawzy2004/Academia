import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';

class CodeVerificationActionButtons extends StatelessWidget {
  final bool isResendEnabled;
  final VoidCallback onResendCode;
  final VoidCallback onGoBack;

  const CodeVerificationActionButtons({
    super.key,
    required this.isResendEnabled,
    required this.onResendCode,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: onGoBack,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
            ),
            ElevatedButton.icon(
              onPressed: isResendEnabled ? onResendCode : null,
              icon: const Icon(Icons.refresh),
              label: Text(isResendEnabled ? 'Resend' : 'Waiting...'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isResendEnabled
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
