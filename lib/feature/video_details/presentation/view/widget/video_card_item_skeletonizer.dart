import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';

class VideoCardItemSkeletonizer extends StatelessWidget {
  const VideoCardItemSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: AppColors.getCardColorTwo(context),
            width: 2.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail skeleton
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.large),
                topRight: Radius.circular(AppRadius.large),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
            ),
            // Video info skeleton
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  Container(
                    width: double.infinity,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(AppRadius.large),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Description skeleton
                  Container(
                    width: double.infinity * 0.7,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(AppRadius.large),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
