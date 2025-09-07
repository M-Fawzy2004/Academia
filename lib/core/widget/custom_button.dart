import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? elevation;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF667EEA),
    this.borderRadius,
    this.textColor = Colors.white,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: elevation,
          shadowColor: backgroundColor!.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
