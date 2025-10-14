import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

class ReminderTypeBadge extends StatelessWidget {
  final ReminderType type;

  const ReminderTypeBadge({
    super.key,
    required this.type,
  });

  Map<String, dynamic> getTypeConfig() {
    switch (type) {
      case ReminderType.subject:
        return {
          'label': 'Subject',
          'icon': IconlyBold.bookmark,
          'color': AppColors.primaryColor,
        };
      case ReminderType.task:
        return {
          'label': 'Task',
          'icon': IconlyBold.tick_square,
          'color': Colors.orange,
        };
      case ReminderType.custom:
        return {
          'label': 'Custom',
          'icon': Icons.edit_note,
          'color': Colors.purple,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = getTypeConfig();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (config['color'] as Color).withOpacity(0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            config['icon'] as IconData,
            size: 14.sp,
            color: config['color'] as Color,
          ),
          widthBox(5),
          Text(
            config['label'] as String,
            style: Styles.font13GreyBold(context).copyWith(
              color: config['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }
}
