import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;
  final bool isNetworkError;
  final VoidCallback onRetry;

  const HomeErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.isNetworkError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isNetworkError ? IconlyLight.danger : IconlyLight.info_circle,
                size: 60.sp,
                color: AppColors.primaryColor,
              ),
            ),
            heightBox(20),
            Text(
              'عذراً!',
              style: Styles.font18MediumBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(10),
            Text(
              message,
              style: Styles.font14MediumBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(
                  Icons.refresh,
                  size: 20.sp,
                ),
                label: Text(
                  'إعادة المحاولة',
                  style: Styles.font14MediumBold(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesNoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const CoursesNoInternetWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.wifi,
                  size: 60.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            heightBox(20),
            Text(
              'No internet connection',
              style: Styles.font18MediumBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(10),
            Text(
              'Please check your internet connection and try again.',
              style: Styles.font14MediumBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(
                  Icons.refresh,
                  size: 20.sp,
                ),
                label: Text(
                  'Retry',
                  style: Styles.font14MediumBold(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
