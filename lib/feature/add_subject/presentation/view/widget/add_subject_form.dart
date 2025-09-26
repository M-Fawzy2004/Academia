import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/subject_data_header.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/year_semester_selector.dart';

class AddSubjectForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController subjectNameController;
  final TextEditingController subjectCodeController;
  final TextEditingController subjectDrNameController;
  final TextEditingController subjectCreditsController;
  final TextEditingController subjectNotesController;
  final String? selectedYear;
  final String? selectedSemester;
  final ValueChanged<String?> onYearChanged;
  final ValueChanged<String?> onSemesterChanged;

  const AddSubjectForm({
    super.key,
    required this.formKey,
    required this.subjectNameController,
    required this.subjectCodeController,
    required this.subjectDrNameController,
    required this.subjectCreditsController,
    required this.subjectNotesController,
    required this.selectedYear,
    required this.selectedSemester,
    required this.onYearChanged,
    required this.onSemesterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YearSemesterSelector(
            initialYear: selectedYear,
            initialSemester: selectedSemester,
            onYearChanged: onYearChanged,
            onSemesterChanged: onSemesterChanged,
            showSelection: true,
          ),
          heightBox(15),
          const SubjectDataHeader(),
          heightBox(15),
          CustomTextField(
            controller: subjectNameController,
            hintText: 'Subject Name',
            suffixIcon: Icons.subject,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Subject name is required';
              }
              return null;
            },
          ),
          heightBox(12),
          CustomTextField(
            controller: subjectCodeController,
            hintText: 'Subject Code (Optional)',
            suffixIcon: Icons.code,
          ),
          heightBox(12),
          CustomTextField(
            controller: subjectDrNameController,
            hintText: 'Doctor Name',
            suffixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Doctor name is required';
              }
              return null;
            },
          ),
          heightBox(12),
          CustomTextField(
            controller: subjectCreditsController,
            hintText: 'Credit Hours',
            suffixIcon: Icons.access_time_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Credit hours is required';
              }
              final hours = int.tryParse(value);
              if (hours == null || hours <= 0 || hours > 10) {
                return 'Credit hours must be between 1 and 10';
              }
              return null;
            },
          ),
          heightBox(12),
          CustomTextField(
            controller: subjectNotesController,
            hintText: 'Notes (Optional)',
            suffixIcon: Icons.note_add,
          ),
        ],
      ),
    );
  }
}
