import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/selected_schedule_display.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/time_selection_dialog.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/week_days_grid.dart';

class LectureDaysSelector extends StatefulWidget {
  final Function(Map<String, Map<String, String>>)? onScheduleChanged;
  final Map<String, Map<String, String>>? initialSchedule;

  const LectureDaysSelector({
    super.key,
    this.onScheduleChanged,
    this.initialSchedule,
  });

  @override
  State<LectureDaysSelector> createState() => _LectureDaysSelectorState();
}

class _LectureDaysSelectorState extends State<LectureDaysSelector> {
  Map<String, Map<String, String>> selectedDaysSchedule = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialSchedule != null) {
      selectedDaysSchedule = Map.from(widget.initialSchedule!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.getFieldColor(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: LanguageHelper.isArabic(context)
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              context.tr.lecture_days,
              style: Styles.font15MediumGreyBold(context),
            ),
          ),
          heightBox(10),
          WeekDaysGrid(
            onDaySelected: _showTimePickerDialog,
            selectedDays: selectedDaysSchedule.keys.toSet(),
          ),
          if (selectedDaysSchedule.isNotEmpty) ...[
            heightBox(15),
            SelectedScheduleDisplay(
              schedule: selectedDaysSchedule,
              onRemoveDay: _removeDaySchedule,
            ),
          ],
        ],
      ),
    );
  }

  void _showTimePickerDialog(String day) {
    showDialog(
      context: context,
      builder: (context) => TimeSelectionDialog(
        day: day,
        onTimeSelected: (timeFrom, timeTo) {
          setState(() {
            selectedDaysSchedule[day] = {
              'from': timeFrom,
              'to': timeTo,
            };
          });
          widget.onScheduleChanged?.call(selectedDaysSchedule);
        },
      ),
    );
  }

  void _removeDaySchedule(String day) {
    setState(() {
      selectedDaysSchedule.remove(day);
    });
    widget.onScheduleChanged?.call(selectedDaysSchedule);
  }
}
