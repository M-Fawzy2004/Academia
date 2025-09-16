import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class StudyStreakWidget extends StatelessWidget {
  const StudyStreakWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.lightSurfaceColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.local_fire_department,
              color: AppColors.lightSurfaceColor,
              size: 24.sp,
            ),
          ),
          widthBox(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.tr.study_streak} 🔥',
                  style: Styles.font15MediumBold(context).copyWith(
                    color: AppColors.lightSurfaceColor,
                  ),
                ),
                heightBox(4),
                Text(
                  '7 ${context.tr.day_keep}',
                  style: Styles.font13GreyBold(context).copyWith(
                    color: AppColors.lightSurfaceColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '20',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.lightSurfaceColor,
            ),
          ),
        ],
      ),
    );
  }
}
