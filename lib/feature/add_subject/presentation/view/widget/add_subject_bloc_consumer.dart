import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/add_subject_view_body.dart';

class AddSubjectBlocConsumer extends StatelessWidget {
  const AddSubjectBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectCubit, SubjectState>(
      listener: (context, state) {
        if (state is SubjectError) {
          CustomSnackBar.showError(context, state.message);
          // Log the error for debugging
          print('Subject Error: ${state.message}');
        }

        if (state is SubjectsLoaded) {
          CustomSnackBar.showInfo(
            context,
            'Subjects loaded successfully',
          );
        }

        if (state is SubjectSuccess) {
          CustomSnackBar.showSuccess(
            context,
            state.message, // Use the actual success message
          );
          // Optionally navigate back or clear form
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return const AddSubjectViewBody();
      },
    );
  }
}