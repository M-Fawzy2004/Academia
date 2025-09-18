import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/year_semester_selector.dart';

class AddSubjectForm extends StatefulWidget {
  const AddSubjectForm({super.key});

  @override
  State<AddSubjectForm> createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  String? selectedYear;
  String? selectedSemester;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YearSemesterSelector(
          initialYear: selectedYear,
          initialSemester: selectedSemester,
          onYearChanged: (String? year) {
            setState(() {
              selectedYear = year;
            });
          },
          onSemesterChanged: (String? semester) {
            setState(() {
              selectedSemester = semester;
            });
          },
          showSelection: true,
        ),
        heightBox(15),
        // Subject Data Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.subject,
                color: AppColors.primaryColor,
                size: 20,
              ),
              widthBox(8),
              Text(
                LanguageHelper.isArabic(context)
                    ? 'بيانات المادة'
                    : 'Material Data',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        heightBox(15),
        CustomTextField(
          hintText:
              LanguageHelper.isArabic(context) ? 'اسم المادة' : 'Subject Name',
          suffixIcon: Icons.subject,
        ),
        heightBox(12),
        CustomTextField(
          hintText: LanguageHelper.isArabic(context)
              ? 'كود المادة (اختياري)'
              : 'Subject Code (Optional)',
          suffixIcon: Icons.code,
        ),
        heightBox(12),
        CustomTextField(
          hintText:
              LanguageHelper.isArabic(context) ? 'اسم الدكتور' : 'Doctor Name',
          suffixIcon: Icons.person,
        ),
        heightBox(12),
        CustomTextField(
          hintText: LanguageHelper.isArabic(context)
              ? 'عدد الساعات (الكريديت)'
              : 'Credit Hours',
          suffixIcon: Icons.access_time_outlined,
        ),
        heightBox(12),
        CustomTextField(
          hintText: LanguageHelper.isArabic(context)
              ? 'ملاحظات (اختياري)'
              : 'Notes (Optional)',
          suffixIcon: Icons.note_add,
        ),
      ],
    );
  }
}
