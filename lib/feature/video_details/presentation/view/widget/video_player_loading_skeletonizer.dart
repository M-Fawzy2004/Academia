import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class VideoPlayerLoadingSkeletonizer extends StatelessWidget {
  const VideoPlayerLoadingSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.getPrimaryColor(context),
            strokeWidth: 3,
          ),
          heightBox(20),
          Text(
            'Loading video...',
            style: TextStyle(
              color: AppColors.getTextColor(context),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}