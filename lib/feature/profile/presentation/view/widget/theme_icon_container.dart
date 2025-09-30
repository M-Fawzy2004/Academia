import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeIconContainer extends StatelessWidget {
  final IconData icon;
  final Gradient gradient;

  const ThemeIconContainer({
    super.key,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }
}
