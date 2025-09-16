import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class AddCoursesButton extends StatelessWidget {
  const AddCoursesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.5.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.lightSurfaceColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                IconlyBold.plus,
                color: AppColors.lightSurfaceColor,
                size: 18.sp,
              ),
            ),
            widthBox(12),
            Text(
              'Add New Course',
              style: Styles.font15MediumBold(context).copyWith(
                color: AppColors.lightSurfaceColor,
              ),
            ),
            widthBox(8),
            Icon(
              IconlyLight.arrow_right,
              color: AppColors.lightSurfaceColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
