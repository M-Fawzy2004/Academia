import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class SubjectInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const SubjectInfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: iconColor ?? AppColors.primaryColor,
        ),
        widthBox(8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.getTextPrimaryColor(context),
            ),
          ),
        ),
      ],
    );
  }
}
