import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_item.dart';

class ReminderItemSkeletonizer extends StatelessWidget {
  const ReminderItemSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (context, index) => heightBox(12),
        itemBuilder: (context, index) {
          final dummyReminder = ReminderEntity(
            id: 'dummy_$index',
            userId: 'dummy',
            title: 'Loading reminder title',
            description: 'Loading reminder description here',
            date: DateTime.now(),
            time: '10:00 AM',
            type: ReminderType.custom,
            isCompleted: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          return ReminderItem(
            reminder: dummyReminder,
            onToggle: () {},
            onDelete: () {},
            onEdit: () {},
          );
        },
      ),
    );
  }
}
