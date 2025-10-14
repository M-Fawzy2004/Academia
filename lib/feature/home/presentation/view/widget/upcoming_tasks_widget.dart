import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class UpcomingTasksWidget extends StatelessWidget {
  const UpcomingTasksWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconlyBold.time_circle,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
            widthBox(8),
            Text(
              context.tr.upcoming_tasks,
              style: Styles.font15MediumBold(context),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                context.tr.view_all,
                style: Styles.font13GreyBold(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        heightBox(12),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.getCardColor(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildTaskItem(
                context: context,
                title: 'Math Assignment Due',
                subtitle: 'Complete calculus problems',
                time: 'Tomorrow, 2:00 PM',
                priority: TaskPriority.high,
                icon: Icons.assignment,
              ),
              heightBox(12),
              _buildTaskItem(
                context: context,
                title: 'Physics Lab Report',
                subtitle: 'Submit experiment analysis',
                time: 'Friday, 11:59 PM',
                priority: TaskPriority.medium,
                icon: Icons.science,
              ),
              heightBox(12),
              _buildTaskItem(
                context: context,
                title: 'Study Group Meeting',
                subtitle: 'Chemistry review session',
                time: 'Saturday, 3:00 PM',
                priority: TaskPriority.low,
                icon: Icons.group,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String time,
    required TaskPriority priority,
    required IconData icon,
  }) {
    Color priorityColor = _getPriorityColor(priority);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: priorityColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: priorityColor,
            size: 18.sp,
          ),
        ),
        widthBox(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.font14MediumEBold(context),
              ),
              heightBox(2),
              Text(
                subtitle,
                style: Styles.font13GreyBold(context),
              ),
              heightBox(4),
              Row(
                children: [
                  Icon(
                    IconlyLight.time_circle,
                    size: 12.sp,
                    color: AppColors.darkGrey,
                  ),
                  widthBox(4),
                  Text(
                    time,
                    style: Styles.font12MediumWhiteBold(context).copyWith(
                      color: priorityColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 4.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: priorityColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
}

enum TaskPriority { high, medium, low }
