import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/subject/presentation/view/widget/subject_card.dart';

class LoadingSubjectsWidget extends StatelessWidget {
  const LoadingSubjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dummySubjects = List.generate(
      5,
      (index) => SubjectEntity(
        id: 'skeleton_$index',
        name: 'Loading Subject Name Here',
        code: 'CODE123',
        doctorName: 'Dr. Loading Name',
        year: 1,
        semester: 1,
        creditHours: 3,
        notes: '',
        resources: const [],
        lectures: const [],
        color: AppColors.primaryColor.withOpacity(0.1).toARGB32(),
        createdAt: now,
        updatedAt: now,
        lastAccessedAt: null,
      ),
    );

    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dummySubjects.length,
        separatorBuilder: (context, index) => heightBox(5),
        itemBuilder: (context, index) {
          return SubjectCard(subject: dummySubjects[index]);
        },
      ),
    );
  }
}
