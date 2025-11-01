import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart' show AppColors;
import 'package:study_box/core/theme/font_weight_helper.dart';

class Styles {
  static TextStyle font28ExtraBlackBold(BuildContext context) => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font11MediumWhiteBold(BuildContext context) => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.darkTextPrimary,
      );

  static TextStyle font13MediumPrimaryBold(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.darkPrimaryColor,
      );

  static TextStyle font13MediumBold(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.lightSurfaceColor,
      );

  static TextStyle font12MediumGreyBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.darkLightGrey,
      );

  static TextStyle font12GreyBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.darkLightGrey,
      );

  static TextStyle font16MediumPrimaryBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.darkPrimaryColor,
      );

  static TextStyle font16MediumBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getDarkGreyColor(context),
      );

  static TextStyle font18MediumBold(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getDarkGreyColor(context),
      );

  static TextStyle font18PrimaryColorTextBold(BuildContext context) =>
      TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextPrimaryColor(context),
      );

  static TextStyle font14MediumBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextPrimaryColor(context),
      );
  static TextStyle font14MediumGreyBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        color: Colors.grey[400],
        fontWeight: FontWeight.w800,
      );

  static TextStyle font11MediumBold(BuildContext context) => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font13MediumEBold(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextColor(context),
      );

  static TextStyle font14PrimaryColorTextBold(BuildContext context) =>
      TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.getTextPrimaryColor(context),
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
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.getTextPrimaryColor(context),
      );
}
