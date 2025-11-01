import 'package:flutter/material.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class SubjectsHeader extends StatelessWidget {
  const SubjectsHeader({super.key, this.onViewAllPressed});
  final VoidCallback? onViewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.tr.subject,
          style: Styles.font14PrimaryColorTextBold(context),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: onViewAllPressed,
          label: Text(
            context.tr.view_all,
            style: Styles.font11MediumBold(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
