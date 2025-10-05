import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/quick_action_button.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({
    super.key,
    required this.onAiSuggestion,
    required this.onAddReminder,
    required this.onAddExternalNote,
  });

  final VoidCallback onAiSuggestion;
  final VoidCallback onAddReminder;
  final VoidCallback onAddExternalNote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuickActionButton(
          icon: Icons.auto_awesome_rounded,
          label: 'Explain with AI',
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
          ),
          onTap: onAiSuggestion,
        ),
        heightBox(12),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.notifications_outlined,
                label: 'Add Reminder',
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF14B8A6)],
                ),
                onTap: onAddReminder,
              ),
            ),
            widthBox(12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.note_add_outlined,
                label: 'Add Note',
                gradient: const LinearGradient(
                  colors: [
                    AppColors.lightTextSecondary,
                    AppColors.darkTextSecondary,
                  ],
                ),
                onTap: onAddExternalNote,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
