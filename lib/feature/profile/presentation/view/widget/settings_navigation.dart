import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';

class SettingsNavigation extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsNavigation({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageHelper.isArabic(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon),
            widthBox(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.font16PrimaryColorTextBold(context),
                  ),
                  if (subtitle != null) ...[
                    heightBox(2),
                    Text(
                      subtitle!,
                      style: Styles.font12MediumBold(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  isArabic
                      ? IconlyLight.arrow_left_2
                      : IconlyLight.arrow_right_2,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
          ],
        ),
      ),
    );
  }
}
