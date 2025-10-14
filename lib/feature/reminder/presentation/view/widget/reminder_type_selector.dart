import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/manager/add_reminder_form_cubit/add_reminder_form_cubit.dart';

class ReminderTypeSelector extends StatelessWidget {
  const ReminderTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReminderFormCubit, AddReminderFormState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8.w,
          children: ReminderType.values.map((type) {
            final isSelected = state.selectedType == type;
            String label = '';
            switch (type) {
              case ReminderType.subject:
                label = 'Subject';
                break;
              case ReminderType.task:
                label = 'Task';
                break;
              case ReminderType.custom:
                label = 'Custom';
                break;
            }
            return ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  context.read<AddReminderFormCubit>().updateType(type);
                }
              },
              selectedColor: AppColors.primaryColor.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primaryColor : null,
                fontWeight: isSelected ? FontWeight.w700 : null,
              ),
              side: BorderSide.none,
            );
          }).toList(),
        );
      },
    );
  }
}
