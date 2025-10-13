import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_config.dart';

class ReminderTypeBadge extends StatelessWidget {
  final ReminderType type;

  const ReminderTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final config = getReminderTypeConfig(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            config.icon,
            size: 14.sp,
            color: config.color,
          ),
          widthBox(5),
          Text(
            config.label,
            style: Styles.font13GreyBold(context).copyWith(
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }
}
