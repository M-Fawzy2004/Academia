import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class DaySelectionChip extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;

  const DaySelectionChip({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.8),
                    AppColors.secondaryColor.withOpacity(0.8),
                  ],
                )
              : null,
          color: isSelected ? null : null,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.darkPrimaryColor,
            width: 1.5.w,
          ),
        ),
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.getTextColor(context),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
