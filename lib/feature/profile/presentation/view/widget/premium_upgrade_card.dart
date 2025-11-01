import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';

class PremiumUpgradeCard extends StatelessWidget {
  const PremiumUpgradeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageHelper.isArabic(context);

    return InkWell(
      onTap: () {
        print('Premium upgrade pressed');
      },
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.large),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Center(
                child: Icon(IconlyBold.star, color: Colors.white, size: 20.sp),
              ),
            ),
            widthBox(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr.upgrade_to_premium,
                    style: Styles.font14PrimaryColorTextBold(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  heightBox(5),
                  Text(
                    context.tr.unlock_all_features,
                    style: Styles.font11MediumBold(
                      context,
                    ).copyWith(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            Icon(
              isArabic ? IconlyLight.arrow_left_2 : IconlyLight.arrow_right_2,
              color: Colors.white,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
