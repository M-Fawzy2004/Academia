import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_state.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_view_body.dart';

class ReminderBlocConsumer extends StatelessWidget {
  const ReminderBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReminderCubit, ReminderState>(
      listener: (context, state) {
        if (state is ReminderError) {
          context.pop();
          CustomSnackBar.showError(context, state.message);
        }
        if (state is ReminderActionSuccess) {
          context.pop();
          CustomSnackBar.showSuccess(context, state.message);
        }
        if (state is ReminderActionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CustomLoadingWidget(),
            ),
          );
        }
      },
      builder: (context, state) {
        return const ReminderViewBody();
      },
    );
  }
}
