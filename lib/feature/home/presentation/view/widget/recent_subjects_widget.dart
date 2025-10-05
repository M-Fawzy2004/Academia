import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/compact_subject_card.dart';

class RecentSubjectsWidget extends StatelessWidget {
  final int maxSubjects;
  final VoidCallback? onViewAllPressed;

  const RecentSubjectsWidget({
    super.key,
    this.maxSubjects = 1,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        if (state is! SubjectsLoaded || state.subjects.isEmpty) {
          return const SizedBox.shrink();
        }

        final sortedSubjects = List.from(state.subjects)
          ..sort((a, b) {
            if (a.lastAccessedAt == null && b.lastAccessedAt == null) {
              return b.createdAt.compareTo(a.createdAt);
            }
            if (a.lastAccessedAt == null) return 1;
            if (b.lastAccessedAt == null) return -1;
            return b.lastAccessedAt!.compareTo(a.lastAccessedAt!);
          });

        final recentSubjects = sortedSubjects.take(maxSubjects).toList();

        return _buildSection(
          context: context,
          title: maxSubjects == 1 ? 'Continue Learning' : 'Recent Subjects',
          subjects: recentSubjects,
        );
      },
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List subjects,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...subjects.map((subject) => CompactSubjectCard(subject: subject)),
      ],
    );
  }
}
