import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/profile/presentation/view/edit_account_view.dart';

class EditAccountButton extends StatelessWidget {
  const EditAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateWithSlideTransition(const EditAccountView());
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Text(
          context.tr.edit_account,
          style: Styles.font13MediumEBold(
            context,
          ).copyWith(fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
    );
  }
}
