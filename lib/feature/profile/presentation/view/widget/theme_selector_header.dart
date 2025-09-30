import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeSelectorHeader extends StatelessWidget {
  const ThemeSelectorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Settings',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextPrimaryColor(context),
                  ),
                ),
                Text(
                  'Choose your preferred theme',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.getTextSecondaryColor(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
