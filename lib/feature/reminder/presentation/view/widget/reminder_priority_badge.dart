import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

class ReminderPriorityBadge extends StatelessWidget {
  final ReminderPriority priority;

  const ReminderPriorityBadge({super.key, required this.priority});

  Color _getPriorityColor() {
    switch (priority) {
      case ReminderPriority.high:
        return Colors.red;
      case ReminderPriority.medium:
        return Colors.orange;
      case ReminderPriority.low:
        return Colors.green;
    }
  }

  IconData _getPriorityIcon() {
    switch (priority) {
      case ReminderPriority.high:
        return Icons.priority_high;
      case ReminderPriority.medium:
        return Icons.remove;
      case ReminderPriority.low:
        return Icons.low_priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getPriorityColor();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 1.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(_getPriorityIcon(), size: 14.sp, color: color)],
      ),
    );
  }
}
