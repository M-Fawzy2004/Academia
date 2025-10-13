import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/data/model/reminder_type_config.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_item.dart';

class ReminderSection extends StatelessWidget {
  final String title;
  final List<ReminderItemData> reminders;

  const ReminderSection({
    super.key,
    required this.title,
    required this.reminders,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.font16PrimaryColorTextBold(context),
        ),
        heightBox(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reminders.length,
          separatorBuilder: (context, index) => heightBox(12),
          itemBuilder: (context, index) {
            return ReminderItem(data: reminders[index]);
          },
        ),
      ],
    );
  }
}
