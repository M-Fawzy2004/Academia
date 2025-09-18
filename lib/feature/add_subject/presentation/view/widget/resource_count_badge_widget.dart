import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class ResourceCountBadgeWidget extends StatelessWidget {
  final int count;

  const ResourceCountBadgeWidget({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
