import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_radius.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary ? const Color(0xFF667EEA) : const Color(0xFFF8FAFC),
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF475569),
          elevation: isPrimary ? 1 : 0,
          shadowColor: const Color(0xFF667EEA).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: const Color(0xFFE2E8F0),
                    width: 1.5.w,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            if (!isPrimary) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
