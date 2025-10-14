import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_state.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/filter_chips_section.dart';

class ReminderFilterSection extends StatelessWidget {
  const ReminderFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderState>(
      builder: (context, state) {
        final cubit = context.read<ReminderCubit>();

        return FilterChipsSection(
          selectedFilter: cubit.currentFilter,
          onFilterChanged: (filter) {
            cubit.filterReminders(filter);
          },
        );
      },
    );
  }
}
