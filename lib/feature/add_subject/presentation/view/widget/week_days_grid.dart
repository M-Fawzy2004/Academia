import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/day_selection_chip.dart';

class WeekDaysGrid extends StatelessWidget {
  final Function(String) onDaySelected;
  final Set<String> selectedDays;

  const WeekDaysGrid({
    super.key,
    required this.onDaySelected,
    required this.selectedDays,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = LanguageHelper.isArabic(context)
        ? [
            'السبت',
            'الأحد',
            'الاثنين',
            'الثلاثاء',
            'الأربعاء',
            'الخميس',
            'الجمعة'
          ]
        : [
            'Saturday',
            'Sunday',
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday'
          ];

    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      children: weekDays
          .map(
            (day) => DaySelectionChip(
              day: day,
              isSelected: selectedDays.contains(day),
              onTap: () => onDaySelected(day),
            ),
          )
          .toList(),
    );
  }
}
