import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_config.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/add_reminder_dialog.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/filter_chips_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_header_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_item.dart';

class ReminderViewBody extends StatefulWidget {
  const ReminderViewBody({super.key});

  @override
  State<ReminderViewBody> createState() => _ReminderViewBodyState();
}

class _ReminderViewBodyState extends State<ReminderViewBody> {
  String selectedFilter = 'All';

  final List<ReminderItemData> allReminders = [
    ReminderItemData(
      title: 'Math Assignment',
      description: 'Complete chapter 5 exercises',
      time: '10:00 AM',
      type: ReminderType.task,
      isCompleted: false,
    ),
    ReminderItemData(
      title: 'Physics Lecture',
      description: 'Quantum mechanics introduction',
      time: '2:00 PM',
      type: ReminderType.subject,
      isCompleted: false,
    ),
    ReminderItemData(
      title: 'Study Chemistry',
      description: 'AI suggested: Review organic chemistry',
      time: 'Tomorrow, 9:00 AM',
      type: ReminderType.ai,
      isCompleted: false,
    ),
    ReminderItemData(
      title: 'Biology Exam',
      description: 'Cell structure and functions',
      time: 'Wed, 3:00 PM',
      type: ReminderType.subject,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ReminderHeaderSection(
            onAddPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddReminderDialog(),
              );
            },
          ),
          heightBox(15),
          FilterChipsSection(
            selectedFilter: selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
          heightBox(15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allReminders.length,
            separatorBuilder: (context, index) => heightBox(12),
            itemBuilder: (context, index) {
              return ReminderItem(data: allReminders[index]);
            },
          ),
          heightBox(15),
        ],
      ),
    );
  }
}
