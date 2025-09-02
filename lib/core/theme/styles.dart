import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart' show AppColors;
import 'package:study_box/core/theme/font_weight_helper.dart';

class Styles {
  static TextStyle font30ExtraBlackBold(BuildContext context) => TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font12MediumWhiteBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.darkTextPrimary,
      );
}
