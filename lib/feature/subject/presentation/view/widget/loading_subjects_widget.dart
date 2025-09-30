import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class LoadingSubjectsWidget extends StatelessWidget {
  const LoadingSubjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLoadingWidget(
              height: 30.h,
            ),
            heightBox(16),
            Text(
              'Loading subjects...',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getDarkGreyColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
