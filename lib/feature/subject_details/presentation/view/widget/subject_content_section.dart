// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/notes_section_bloc_consumer.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/quick_actions_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resources_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_header_card.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/lecture_schedule_section.dart';

class SubjectContentSection extends StatelessWidget {
  const SubjectContentSection({
    super.key,
    required this.s,
    required this.mounted,
    required this.subjectId,
  });

  final SubjectEntity s;
  final bool mounted;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubjectHeaderCard(
          subjectName: s.name,
          instructorName: s.doctorName,
          hours: s.creditHours,
          onDelete: () async {
            await context.read<SubjectCubit>().deleteSubject(s.id);
            if (mounted) Navigator.of(context).pop();
          },
        ),
        heightBox(15),
        QuickActionsSection(
          onAiSuggestion: () {
            CustomSnackBar.showInfo(context, 'Soon');
          },
          onAddReminder: () {
            CustomSnackBar.showInfo(context, 'Soon');
          },
        ),
        heightBox(15),
        NotesSectionBlocConsumer(subjectId: subjectId),
        heightBox(15),
        LectureScheduleSection(subject: s),
        heightBox(15),
        ResourcesSection(subject: s),
        heightBox(20),
      ],
    );
  }
}
