import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      backgroundColor: AppColors.getNavigationBar(context),
      title: Text(
        '${context.tr.set_time} ${widget.day}',
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
                  label: context.tr.from,
                  time: fromTime,
                  onTimeSelected: (time) => setState(() => fromTime = time),
                ),
              ),
              widthBox(10),
              Expanded(
                child: TimeSelectionBox(
                  label: context.tr.to,
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
            'Cancel',
            style: Styles.font11MediumBold(context).copyWith(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: _canSave() ? _saveTime : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
          ),
          child: Text(
            context.tr.save,
            style: Styles.font13MediumEBold(context),
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
