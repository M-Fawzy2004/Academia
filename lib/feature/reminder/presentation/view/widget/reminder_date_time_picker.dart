import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/reminder/presentation/manager/add_reminder_form_cubit/add_reminder_form_cubit.dart';

class ReminderDateTimePicker extends StatelessWidget {
  const ReminderDateTimePicker({super.key});

  Future<void> pickDate(BuildContext context, DateTime currentDate) async {
    final date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null && context.mounted) {
      context.read<AddReminderFormCubit>().updateDate(date);
    }
  }

  Future<void> pickTime(BuildContext context, TimeOfDay currentTime) async {
    final time = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (time != null && context.mounted) {
      context.read<AddReminderFormCubit>().updateTime(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReminderFormCubit, AddReminderFormState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => pickDate(context, state.selectedDate),
                icon: const Icon(IconlyLight.calendar, size: 20),
                label: Text(
                  '${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}',
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  side: BorderSide.none,
                  backgroundColor: AppColors.getCardColorTwo(context),
                ),
              ),
            ),
            widthBox(12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => pickTime(context, state.selectedTime),
                icon: const Icon(IconlyLight.time_circle, size: 20),
                label: Text(state.selectedTime.format(context)),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  side: BorderSide.none,
                  backgroundColor: AppColors.getCardColorTwo(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
