import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/add_reminder_dialog.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_filter_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_header_section.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_list_section.dart';

class ReminderViewBody extends StatelessWidget {
  const ReminderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReminderCubit>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ReminderHeaderSection(
            onAddPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddReminderDialog(cubit: cubit),
              );
            },
          ),
          heightBox(15),
          const ReminderFilterSection(),
          heightBox(15),
          ReminderListSection(cubit: cubit),
          heightBox(15),
        ],
      ),
    );
  }
}
