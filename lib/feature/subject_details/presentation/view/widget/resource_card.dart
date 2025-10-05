import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/styles.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    super.key,
    required this.name,
    this.subtitle,
    required this.iconColor,
    required this.icon,
  });

  final String name;
  final String? subtitle;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Styles.font13GreyBold(context).copyWith(
                    fontSize: 15.sp,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: Styles.font13GreyBold(context),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}
