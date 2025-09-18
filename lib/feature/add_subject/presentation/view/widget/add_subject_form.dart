import 'package:flutter/material.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class AddSubjectForm extends StatefulWidget {
  const AddSubjectForm({super.key});

  @override
  State<AddSubjectForm> createState() => _AddSubjectFormState();
}

class _AddSubjectFormState extends State<AddSubjectForm> {
  String? selectedYear;
  String? selectedSemester;

  List<String> get years => [
        LanguageHelper.isArabic(context) ? 'الفرقه الأولى' : 'First Year',
        LanguageHelper.isArabic(context) ? 'الفرقه الثانية' : 'Second Year',
        LanguageHelper.isArabic(context) ? 'الفرقه الثالثة' : 'Third Year',
        LanguageHelper.isArabic(context) ? 'الفرقه الرابعة' : 'Fourth Year',
        LanguageHelper.isArabic(context) ? 'الفرقه الخامسة' : 'Fifth Year',
        LanguageHelper.isArabic(context) ? 'الفرقه السادسة' : 'Sixth Year',
        LanguageHelper.isArabic(context) ? 'الفرقه السابعة' : 'Seventh Year',
      ];

  List<String> get semesters => [
        LanguageHelper.isArabic(context) ? 'الترم الأول' : 'First Semester',
        LanguageHelper.isArabic(context) ? 'الترم الثاني' : 'Second Semester',
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.school,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                LanguageHelper.isArabic(context)
                    ? 'معلومات السنة والترم'
                    : 'Year and Semester Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        heightBox(15),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: LanguageHelper.isArabic(context)
                  ? 'اختر السنة'
                  : 'Select Year',
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            value: selectedYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(
                  year,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue;
              });
            },
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          ),
        ),
        heightBox(10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: LanguageHelper.isArabic(context)
                  ? 'اختر الترم'
                  : 'Select Semester',
              prefixIcon: const Icon(Icons.timeline, color: Colors.green),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            value: selectedSemester,
            items: semesters.map((String semester) {
              return DropdownMenuItem<String>(
                value: semester,
                child: Text(
                  semester,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSemester = newValue;
              });
            },
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
          ),
        ),
        heightBox(20),
        if (selectedYear != null || selectedSemester != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    LanguageHelper.isArabic(context)
                        ? 'الاختيار الحالي: ${selectedYear ?? ''} ${selectedSemester != null ? '- $selectedSemester' : ''}'
                        : 'Current selection: ${selectedYear ?? ''} ${selectedSemester != null ? '- $selectedSemester' : ''}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

        if (selectedYear != null || selectedSemester != null) heightBox(15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.1),
                Colors.orange.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.orange.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.subject,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                LanguageHelper.isArabic(context)
                    ? 'بيانات المادة'
                    : 'Material Data',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        heightBox(15),

        // باقي الحقول
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
