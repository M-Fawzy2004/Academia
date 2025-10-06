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
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(right: isSelected ? 0 : 60.w),
            decoration: BoxDecoration(
              color: AppColors.getCardColor(context),
              borderRadius: BorderRadius.circular(24.r),
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
                    padding: EdgeInsets.only(left: 16.w),
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
            right: isSelected ? 16.w : 0,
            top: 0,
            bottom: 0,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 600),
              turns: isSelected ? 0 : 0.15,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: isSelected ? 1.1 : 1.0,
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.colors.first.withOpacity(
                          isSelected ? 0.5 : 0.25,
                        ),
                        blurRadius: isSelected ? 24 : 16,
                        offset: Offset(0, isSelected ? 8 : 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      if (isSelected)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _DecorLinePainter(),
                          ),
                        ),
                      Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                    ],
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

class _DecorLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.7, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.6, 0),
      Offset(size.width, size.height * 0.7),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
