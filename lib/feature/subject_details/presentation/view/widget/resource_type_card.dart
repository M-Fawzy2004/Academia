import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';

class ResourceTypeCard extends StatelessWidget {
  const ResourceTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.count,
    required this.items,
    required this.onViewAll,
  });

  final String title;
  final IconData icon;
  final Gradient gradient;
  final int count;
  final List<Map<String, String>> items;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
                widthBox(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Styles.font14PrimaryColorTextBold(context),
                      ),
                      heightBox(2),
                      Text(
                        '$count files',
                        style: Styles.font12GreyBold(context).copyWith(
                          fontSize: 12.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onViewAll,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: gradient.colors.first.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      border: Border.all(
                        color: gradient.colors.first.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr.view_all,
                          style: Styles.font12GreyBold(context).copyWith(
                            fontSize: 12.sp,
                            color: gradient.colors.first,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widthBox(5),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12.sp,
                          color: gradient.colors.first,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
