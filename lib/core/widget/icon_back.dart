import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/language_helper.dart';
import '../theme/app_color.dart';

class IconBack extends StatelessWidget {
  const IconBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: AppColors.getCardColorTwo(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          LanguageHelper.isArabic(context)
              ? IconlyLight.arrow_right_2
              : IconlyLight.arrow_left_2,
          color: AppColors.primaryColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
