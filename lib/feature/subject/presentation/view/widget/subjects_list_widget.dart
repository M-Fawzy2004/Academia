import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/subject/presentation/view/widget/subject_card.dart';

class SubjectsListWidget extends StatelessWidget {
  final List<SubjectEntity> subjects;

  const SubjectsListWidget({
    super.key,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      separatorBuilder: (context, index) => heightBox(5),
      itemBuilder: (context, index) {
        return SubjectCard(subject: subjects[index]);
      },
    );
  }
}
