import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_item_grid.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/book_item_skeleton_loader.dart';

class BookItemGridBlocConsumer extends StatelessWidget {
  const BookItemGridBlocConsumer({super.key});

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
          return const BookItemSkeletonLoader();
        }

        if (state is SubjectLoaded) {
          return BookItemGrid(subject: state.subject);
        }

        return const Expanded(
          child: Center(
            child: Text('No Book item files found'),
          ),
        );
      },
    );
  }
}
