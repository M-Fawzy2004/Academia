import 'package:flutter/material.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/schedule_item.dart';

class SelectedScheduleDisplay extends StatelessWidget {
  final Map<String, Map<String, String>> schedule;
  final Function(String) onRemoveDay;

  const SelectedScheduleDisplay({
    super.key,
    required this.schedule,
    required this.onRemoveDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...schedule.entries.map(
          (entry) => ScheduleItem(
            day: entry.key,
            timeFrom: entry.value['from']!,
            timeTo: entry.value['to']!,
            onRemove: () => onRemoveDay(entry.key),
          ),
        ),
      ],
    );
  }
}
