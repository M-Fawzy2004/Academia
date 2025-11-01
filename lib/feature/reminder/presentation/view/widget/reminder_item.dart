import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_badge.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_priority_badge.dart';

class ReminderItem extends StatelessWidget {
  final ReminderEntity reminder;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ReminderItem({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final reminderDate = DateTime(date.year, date.month, date.day);

    if (reminderDate == today) {
      return 'Today';
    } else if (reminderDate == tomorrow) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
          width: 1.5.w,
        ),
      ),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(AppRadius.large),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: reminder.isCompleted
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: reminder.isCompleted
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                    child: reminder.isCompleted
                        ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                        : null,
                  ),
                ),
                widthBox(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              reminder.title,
                              style: Styles.font14PrimaryColorTextBold(context)
                                  .copyWith(
                                    decoration: reminder.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: reminder.isCompleted
                                        ? Colors.grey.shade600
                                        : null,
                                  ),
                            ),
                          ),
                          ReminderPriorityBadge(priority: reminder.priority),
                          widthBox(6),
                          ReminderTypeBadge(type: reminder.type),
                        ],
                      ),
                      Text(
                        reminder.description,
                        style: Styles.font12GreyBold(context).copyWith(
                          decoration: reminder.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(5),
                      Row(
                        children: [
                          Icon(
                            IconlyLight.calendar,
                            size: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                          widthBox(3),
                          Text(
                            formatDate(reminder.date),
                            style: Styles.font12GreyBold(context),
                          ),
                          widthBox(10),
                          Icon(
                            IconlyLight.time_circle,
                            size: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                          widthBox(3),
                          Text(
                            reminder.time,
                            style: Styles.font12GreyBold(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    IconlyLight.delete,
                    color: Colors.red.shade400,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
