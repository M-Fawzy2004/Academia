import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/theme/app_color.dart';

ReminderTypeConfig getReminderTypeConfig(ReminderType type) {
  switch (type) {
    case ReminderType.subject:
      return ReminderTypeConfig(
        label: 'Subject',
        icon: IconlyBold.bookmark,
        color: AppColors.primaryColor,
      );
    case ReminderType.task:
      return ReminderTypeConfig(
        label: 'Task',
        icon: IconlyBold.tick_square,
        color: Colors.orange,
      );
    case ReminderType.ai:
      return ReminderTypeConfig(
        label: 'AI',
        icon: Icons.auto_awesome,
        color: Colors.purple,
      );
  }
}

enum ReminderType {
  subject,
  task,
  ai,
}

class ReminderItemData {
  final String title;
  final String description;
  final String time;
  final ReminderType type;
  final bool isCompleted;

  ReminderItemData({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isCompleted,
  });
}

class ReminderTypeConfig {
  final String label;
  final IconData icon;
  final Color color;

  ReminderTypeConfig({
    required this.label,
    required this.icon,
    required this.color,
  });
}
