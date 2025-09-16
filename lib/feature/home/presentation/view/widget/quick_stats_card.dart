import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context: context,
            icon: IconlyBold.document,
            title: context.tr.total_subject,
            value: '12',
            color: Colors.blue,
          ),
        ),
        widthBox(12),
        Expanded(
          child: _buildStatCard(
            context: context,
            icon: IconlyBold.time_circle,
            title: context.tr.tasks,
            value: '10',
            color: Colors.green,
          ),
        ),
        widthBox(12),
        Expanded(
          child: _buildStatCard(
            context: context,
            icon: IconlyBold.star,
            title: context.tr.completed_tasks,
            value: '5',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1.5.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          heightBox(8),
          Text(
            value,
            style: Styles.font18MediumBold(context),
          ),
          heightBox(4),
          Text(
            title,
            style: Styles.font12MediumBold(context),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
