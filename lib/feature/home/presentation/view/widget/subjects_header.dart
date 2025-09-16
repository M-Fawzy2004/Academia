import 'package:flutter/material.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class SubjectsHeader extends StatelessWidget {
  const SubjectsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.tr.subject,
          style: Styles.font20MediumBold(context),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () {},
          label: Text(
            context.tr.view_all,
            style: Styles.font13GreyBold(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
