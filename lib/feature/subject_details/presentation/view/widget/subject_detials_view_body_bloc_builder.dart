import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_content_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_details_skeletonizer.dart';

class SubjectDetialsViewBodyBlocBuilder extends StatelessWidget {
  const SubjectDetialsViewBodyBlocBuilder({
    super.key,
    required this.mounted,
    required this.subjectId,
  });

  final bool mounted;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        if (state is SubjectLoading) {
          return const SubjectDetailsSkeletonizer();
        }
        if (state is SubjectLoaded) {
          final s = state.subject;
          return SubjectContentSection(
            s: s,
            mounted: mounted,
            subjectId: subjectId,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
