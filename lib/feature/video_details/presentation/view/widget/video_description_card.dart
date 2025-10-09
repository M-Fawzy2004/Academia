import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class VideoDescriptionCard extends StatelessWidget {
  const VideoDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.getCardColorTwo(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.getPrimaryColor(context),
                  size: 20.r,
                ),
                widthBox(8),
                Text(
                  'About this video',
                  style: TextStyle(
                    color: AppColors.getTextColor(context),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            heightBox(12),
            Text(
              'This video is part of your study material. Make sure to watch it carefully and take notes for better understanding.',
              style: TextStyle(
                color: AppColors.getTextColor(context).withOpacity(0.7),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            heightBox(16),
            Row(
              children: [
                _buildFeature(
                  context,
                  icon: Icons.hd_rounded,
                  label: 'HD Quality',
                ),
                widthBox(16),
                _buildFeature(
                  context,
                  icon: Icons.fullscreen_rounded,
                  label: 'Full Screen',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(BuildContext context,
      {required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.getPrimaryColor(context),
          size: 16.r,
        ),
        widthBox(6),
        Text(
          label,
          style: TextStyle(
            color: AppColors.getTextColor(context).withOpacity(0.8),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}