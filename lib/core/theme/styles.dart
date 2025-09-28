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

  static TextStyle font14MediumPrimaryBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.darkPrimaryColor,
      );

  static TextStyle font14MediumBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.lightSurfaceColor,
      );

  static TextStyle font13MediumGreyBold(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.darkLightGrey,
      );

  static TextStyle font13GreyBold(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.darkLightGrey,
      );

  static TextStyle font18MediumPrimaryBold(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.darkPrimaryColor,
      );

  static TextStyle font18MediumBold(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getDarkGreyColor(context),
      );

  static TextStyle font20MediumBold(BuildContext context) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getDarkGreyColor(context),
      );

  static TextStyle font15MediumBold(BuildContext context) => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextPrimaryColor(context),
      );
  static TextStyle font15MediumGreyBold(BuildContext context) => TextStyle(
        fontSize: 15.sp,
        color: Colors.grey[400],
        fontWeight: FontWeight.w800,
      );

  static TextStyle font12MediumBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font14MediumEBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font15PrimaryColorTextBold(BuildContext context) =>
      TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.getTextPrimaryColor(context),
      );

  static TextStyle font16PrimaryColorTextBold(BuildContext context) =>
      TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.getTextPrimaryColor(context),
      );

  static TextStyle font18PrimaryColorTextBold(BuildContext context) =>
      TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextPrimaryColor(context),
      );
}
