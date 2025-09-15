import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            endIndent: 20.sp,
            thickness: 1,
            color: AppColors.darkLightGrey,
          ),
        ),
        Text(
          "OR",
          style: Styles.font14MediumPrimaryBold(context),
        ),
        Expanded(
          child: Divider(
            indent: 20.sp,
            thickness: 1,
            color: AppColors.darkLightGrey,
          ),
        ),
      ],
    );
  }
}
