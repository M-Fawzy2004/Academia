import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(
              right: isRTL ? 0 : (isSelected ? 0 : 40.w),
              left: isRTL ? (isSelected ? 0 : 40.w) : 0,
            ),
            decoration: BoxDecoration(
              color: AppColors.getCardColor(context),
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: isSelected
                    ? gradient.colors.first
                    : AppColors.getBorderColor(context).withOpacity(0.3),
                width: isSelected ? 2.5.w : 1.w,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: isSelected ? 6.w : 4.w,
                        height: isSelected ? 6.w : 4.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: gradient,
                        ),
                      ),
                      widthBox(10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: AppColors.getTextColor(context),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  heightBox(8),
                  Padding(
                    padding: EdgeInsets.only(
                      left: isRTL ? 0 : 16.w,
                      right: isRTL ? 16.w : 0,
                    ),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.getTextColor(context).withOpacity(0.5),
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            right: isRTL ? null : (isSelected ? 16.w : 0),
            left: isRTL ? (isSelected ? 16.w : 0) : null,
            top: 0,
            bottom: 0,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 600),
              turns: isSelected ? 0 : (isRTL ? -0.2 : 0.2),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: isSelected ? 1.0 : 1.0,
                child: Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
