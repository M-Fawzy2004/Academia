import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/pdf_details/presentation/view/widget/pdf_file_grid.dart';
import 'package:study_box/feature/pdf_details/presentation/view/widget/pdf_file_grid_shimmer.dart';

class PdfFileGridBlocConsumer extends StatelessWidget {
  const PdfFileGridBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectCubit, SubjectState>(
      listener: (context, state) {
        if (state is SubjectError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is SubjectLoading) {
          return const PdfFileGridShimmer();
        }

        if (state is SubjectLoaded) {
          return PdfFileGrid(subject: state.subject);
        }

        return const Expanded(
          child: Center(
            child: Text('No PDF files found'),
          ),
        );
      },
    );
  }
}
