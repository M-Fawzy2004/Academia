import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/manager/add_reminder_form_cubit/add_reminder_form_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/add_reminder_dialog_content.dart';

class AddReminderDialog extends StatelessWidget {
  final ReminderCubit cubit;
  final ReminderEntity? reminder;

  const AddReminderDialog({
    super.key,
    required this.cubit,
    this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReminderCubit>.value(
          value: cubit,
        ),
        BlocProvider<AddReminderFormCubit>(
          create: (_) => AddReminderFormCubit()..initializeForm(reminder),
        ),
      ],
      child: AddReminderDialogContent(reminder: reminder),
    );
  }
}
