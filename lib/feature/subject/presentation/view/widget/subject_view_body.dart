import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/subject/data/model/subject_model.dart';
import 'package:study_box/feature/subject/presentation/view/widget/custom_search_widget.dart';
import 'package:study_box/feature/subject/presentation/view/widget/subject_card.dart';

class SubjectViewBody extends StatelessWidget {
  const SubjectViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(30),
          Text(
            'Study Subjects',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.getTextPrimaryColor(context),
            ),
          ),
          heightBox(20),
          CustomSearchWidget(
            showGradeFilter: true,
            showSemesterFilter: true,
            onSearchChanged: (query, grade, semester) {},
          ),
          heightBox(5),
          _buildSubjectsList(context),
        ],
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    final subjects = _getDummySubjects(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      separatorBuilder: (context, index) => heightBox(16),
      itemBuilder: (context, index) {
        return SubjectCard(subject: subjects[index]);
      },
    );
  }

  List<SubjectModel> _getDummySubjects(BuildContext context) {
    return [
      const SubjectModel(
        title: 'Mathematics',
        grade: 'First Grade',
        semester: 'First Semester',
        resources: [
          'Textbook',
          'PDF Summaries',
          'Video Lectures',
          'Past Exams'
        ],
        color: AppColors.primaryColor,
        icon: Icons.calculate_rounded,
      ),
      const SubjectModel(
        title: 'Physics',
        grade: 'Second Grade',
        semester: 'Second Semester',
        resources: ['Textbook', 'Lab Experiments', 'PDF Summaries'],
        color: Color(0xFF7B68EE),
        icon: Icons.science_rounded,
      ),
      const SubjectModel(
        title: 'Chemistry',
        grade: 'First Grade',
        semester: 'First Semester',
        resources: [
          'Textbook',
          'Periodic Tables',
          'Chemical Reactions',
          'Videos'
        ],
        color: Color(0xFF50C878),
        icon: Icons.biotech_rounded,
      ),
      const SubjectModel(
        title: 'Arabic Language',
        grade: 'Third Grade',
        semester: 'First Semester',
        resources: ['Literature Book', 'Grammar Rules', 'Poetry Texts'],
        color: Color(0xFFFF6B6B),
        icon: Icons.book_rounded,
      ),
      const SubjectModel(
        title: 'History',
        grade: 'Second Grade',
        semester: 'Second Semester',
        resources: ['History Book', 'Historical Maps', 'Documents'],
        color: Color(0xFFFFB347),
        icon: Icons.history_edu_rounded,
      ),
    ];
  }
}
