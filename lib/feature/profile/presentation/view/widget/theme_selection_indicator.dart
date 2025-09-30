import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeSelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const ThemeSelectionIndicator({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.getBorderColor(context),
          width: 2,
        ),
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              color: Colors.white,
              size: 16.sp,
            )
          : null,
    );
  }
}
