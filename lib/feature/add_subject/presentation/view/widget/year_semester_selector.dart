import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';

class YearSemesterSelector extends StatefulWidget {
  final String? initialYear;
  final String? initialSemester;
  final Function(String?)? onYearChanged;
  final Function(String?)? onSemesterChanged;
  final bool showSelection;

  const YearSemesterSelector({
    super.key,
    this.initialYear,
    this.initialSemester,
    this.onYearChanged,
    this.onSemesterChanged,
    this.showSelection = true,
  });

  @override
  State<YearSemesterSelector> createState() => _YearSemesterSelectorState();
}

class _YearSemesterSelectorState extends State<YearSemesterSelector> {
  String? selectedYear;
  String? selectedSemester;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialYear;
    selectedSemester = widget.initialSemester;
  }

  List<String> get years => [
    context.tr.first_year,
    context.tr.second_year,
    context.tr.third_year,
    context.tr.fourth_year,
    context.tr.fifth_year,
    context.tr.sixth_year,
    context.tr.seventh_year,
  ];

  List<String> get semesters => [
    context.tr.first_semester,
    context.tr.second_semester,
  ];

  void _onYearChanged(String? newValue) {
    setState(() {
      selectedYear = newValue;
    });
    if (widget.onYearChanged != null) {
      widget.onYearChanged!(newValue);
    }
  }

  void _onSemesterChanged(String? newValue) {
    setState(() {
      selectedSemester = newValue;
    });
    if (widget.onSemesterChanged != null) {
      widget.onSemesterChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.large),
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
              widthBox(8),
              Text(
                context.tr.info_year_and_semester,
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
        // Year Dropdown
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            color: AppColors.getFieldColor(context),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: context.tr.select_year,
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 12.h,
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
            onChanged: _onYearChanged,
            dropdownColor: AppColors.getFieldColor(context),
            borderRadius: BorderRadius.circular(AppRadius.large),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          ),
        ),
        heightBox(10),
        // Semester Dropdown
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            color: AppColors.getFieldColor(context),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: context.tr.select_semester,
              prefixIcon: const Icon(Icons.timeline, color: Colors.green),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 12.h,
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
            onChanged: _onSemesterChanged,
            dropdownColor: AppColors.getFieldColor(context),
            borderRadius: BorderRadius.circular(AppRadius.large),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
          ),
        ),
        heightBox(20),
        // Current Selection Info (Optional)
        if (widget.showSelection &&
            (selectedYear != null || selectedSemester != null))
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.large),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${context.tr.current_selection} ${selectedYear ?? ''} ${selectedSemester != null ? '- $selectedSemester' : ''}',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
