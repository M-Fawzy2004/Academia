import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_state.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/add_reminder_dialog.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_item.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_item_skeletonizer.dart';

class ReminderListSection extends StatelessWidget {
  const ReminderListSection({
    super.key,
    required this.cubit,
  });

  final ReminderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderState>(
      builder: (context, state) {
        if (state is ReminderLoading) {
          return const ReminderItemSkeletonizer();
        }

        if (state is ReminderLoaded) {
          if (state.reminders.isEmpty) {
            return Column(
              children: [
                heightBox(150),
                Icon(
                  Icons.calendar_month_outlined,
                  size: 100.sp,
                  color: Colors.grey,
                ),
                heightBox(20),
                Text(
                  'No reminders found',
                  style: Styles.font15PrimaryColorTextBold(context).copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.reminders.length,
            separatorBuilder: (context, index) => heightBox(12),
            itemBuilder: (context, index) {
              final reminder = state.reminders[index];
              return ReminderItem(
                reminder: reminder,
                onToggle: () {
                  cubit.toggleReminderCompletion(
                    reminder.id,
                    !reminder.isCompleted,
                  );
                },
                onDelete: () {
                  cubit.deleteReminder(reminder.id);
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddReminderDialog(
                      cubit: cubit,
                      reminder: reminder,
                    ),
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

