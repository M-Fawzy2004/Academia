import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class ReminderHeaderSection extends StatelessWidget {
  final VoidCallback onAddPressed;

  const ReminderHeaderSection({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Reminders',
          style: Styles.font14PrimaryColorTextBold(context),
        ),
        const Spacer(),
        IconButton(
          onPressed: onAddPressed,
          icon: const Icon(
            IconlyBold.plus,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
