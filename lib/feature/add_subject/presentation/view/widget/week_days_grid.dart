import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/localization/translate.dart';
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
    final List<String> weekDays = [
      context.tr.saturday,
      context.tr.sunday,
      context.tr.monday,
      context.tr.tuesday,
      context.tr.wednesday,
      context.tr.thursday,
      context.tr.friday,
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
