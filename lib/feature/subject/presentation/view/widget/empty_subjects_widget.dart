import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class EmptySubjectsWidget extends StatelessWidget {
  final bool hasFilters;

  const EmptySubjectsWidget({
    super.key,
    this.hasFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasFilters ? Icons.search_off_rounded : Icons.book_outlined,
              size: 80.sp,
              color: AppColors.getDarkGreyColor(context).withOpacity(0.5),
            ),
            heightBox(16),
            Text(
              hasFilters ? 'No subjects found' : 'No subjects yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.getTextPrimaryColor(context),
              ),
            ),
            heightBox(8),
            Text(
              hasFilters
                  ? 'Try adjusting your filters'
                  : 'Add your first subject to get started',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getDarkGreyColor(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
