import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/time_selection_box.dart';

class TimeSelectionDialog extends StatefulWidget {
  final String day;
  final Function(String, String) onTimeSelected;

  const TimeSelectionDialog({
    super.key,
    required this.day,
    required this.onTimeSelected,
  });

  @override
  State<TimeSelectionDialog> createState() => _TimeSelectionDialogState();
}

class _TimeSelectionDialogState extends State<TimeSelectionDialog> {
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageHelper.isArabic(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: AppColors.getNavigationBar(context),
      title: Text(
        isArabic ? 'تحديد وقت ${widget.day}' : 'Set time for ${widget.day}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TimeSelectionBox(
                  label: isArabic ? 'من' : 'From',
                  time: fromTime,
                  onTimeSelected: (time) => setState(() => fromTime = time),
                ),
              ),
              widthBox(10),
              Expanded(
                child: TimeSelectionBox(
                  label: isArabic ? 'إلى' : 'To',
                  time: toTime,
                  onTimeSelected: (time) => setState(() => toTime = time),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            isArabic ? 'إلغاء' : 'Cancel',
            style: Styles.font12MediumBold(context).copyWith(
              color: Colors.red,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _canSave() ? _saveTime : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            isArabic ? 'حفظ' : 'Save',
            style: Styles.font14MediumEBold(context),
          ),
        ),
      ],
    );
  }

  bool _canSave() => fromTime != null && toTime != null;

  void _saveTime() {
    if (_canSave()) {
      widget.onTimeSelected(
        _formatTimeOfDay(fromTime!),
        _formatTimeOfDay(toTime!),
      );
      Navigator.pop(context);
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}
