import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/reminder/data/model/reminder_type_config.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/add_reminder_dialog.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/filter_chips_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_header_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_section.dart';

class ReminderViewBody extends StatefulWidget {
  const ReminderViewBody({super.key});

  @override
  State<ReminderViewBody> createState() => _ReminderViewBodyState();
}

class _ReminderViewBodyState extends State<ReminderViewBody> {
  String selectedFilter = 'All';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReminderSection(
                title: 'Today',
                reminders: [
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
                ],
              ),
              heightBox(24),
              ReminderSection(
                title: 'Tomorrow',
                reminders: [
                  ReminderItemData(
                    title: 'Study Chemistry',
                    description: 'AI suggested: Review organic chemistry',
                    time: '9:00 AM',
                    type: ReminderType.ai,
                    isCompleted: false,
                  ),
                ],
              ),
              heightBox(24),
              ReminderSection(
                title: 'This Week',
                reminders: [
                  ReminderItemData(
                    title: 'Biology Exam',
                    description: 'Cell structure and functions',
                    time: 'Wed, 3:00 PM',
                    type: ReminderType.subject,
                    isCompleted: false,
                  ),
                ],
              ),
              heightBox(15),
            ],
          ),
        ],
      ),
    );
  }
}
