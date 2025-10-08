import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class DecorativeShapes extends StatelessWidget {
  const DecorativeShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Right - Book Icon Shape
        Positioned(
          top: 30.h,
          right: -40.w,
          child: Transform.rotate(
            angle: -0.2,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF667EEA).withOpacity(0.15),
                    const Color(0xFF764BA2).withOpacity(0.04),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 50.sp,
                  color: const Color(0xFF667EEA).withOpacity(0.15),
                ),
              ),
            ),
          ),
        ),

        // Top Left - Graduation Cap
        Positioned(
          top: 110.h,
          left: 0.w,
          child: Transform.rotate(
            angle: 0.15,
            child: Icon(
              Icons.school_rounded,
              size: 35.sp,
              color: const Color(0xFF667EEA).withOpacity(0.12),
            ),
          ),
        ),

        // Middle Right - Pencil/Edit Icon
        Positioned(
          top: 220.h,
          right: 0.w,
          child: Transform.rotate(
            angle: 0.3,
            child: Icon(
              Icons.edit_rounded,
              size: 28.sp,
              color: const Color(0xFFF093FB).withOpacity(0.12),
            ),
          ),
        ),

        // Bottom Left - Lightbulb (Ideas)
        Positioned(
          bottom: 100.h,
          left: 15.w,
          child: Icon(
            Icons.lightbulb_outline_rounded,
            size: 32.sp,
            color: const Color(0xFFFEAC5E).withOpacity(0.15),
          ),
        ),

        // Bottom Right - Certificate/Award
        Positioned(
          bottom: 0.h,
          left: -35.w,
          child: Transform.rotate(
            angle: -0.2,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFA709A).withOpacity(0.08),
                    const Color(0xFFFEE140).withOpacity(0.04),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 45.sp,
                  color: const Color(0xFFFA709A).withOpacity(0.15),
                ),
              ),
            ),
          ),
        ),

        // Floating Small Book
        Positioned(
          top: 180.h,
          left: -10.w,
          child: Transform.rotate(
            angle: -0.4,
            child: Icon(
              Icons.auto_stories_rounded,
              size: 26.sp,
              color: const Color(0xFF4FACFE).withOpacity(0.12),
            ),
          ),
        ),

        // Middle - Study/Reading Icon
        Positioned(
          top: 280.h,
          left: 30.w,
          child: Icon(
            Icons.chrome_reader_mode_rounded,
            size: 24.sp,
            color: const Color(0xFF667EEA).withOpacity(0.1),
          ),
        ),

        // Geometric Academic Patterns
        Positioned(
          top: 100.h,
          right: 60.w,
          child: CustomPaint(
            size: Size(40.w, 40.h),
            painter: AcademicPatternPainter(),
          ),
        ),

        // Bottom Center - Small Star (Excellence)
        Positioned(
          bottom: 150.h,
          right: 50.w,
          child: CustomPaint(
            size: Size(25.w, 25.h),
            painter: SimpleStarPainter(),
          ),
        ),
      ],
    );
  }
}

// Academic Pattern - Grid Lines
class AcademicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF667EEA).withOpacity(0.08)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw grid pattern
    for (var i = 0; i <= 3; i++) {
      // Horizontal lines
      canvas.drawLine(
        Offset(0, size.height / 3 * i),
        Offset(size.width, size.height / 3 * i),
        paint,
      );
      // Vertical lines
      canvas.drawLine(
        Offset(size.width / 3 * i, 0),
        Offset(size.width / 3 * i, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple Star for Excellence
class SimpleStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFDC830).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius / 2.5;

    for (var i = 0; i < 5; i++) {
      final outerAngle = (i * 72 - 90) * math.pi / 180;
      final innerAngle = ((i * 72 + 36) - 90) * math.pi / 180;

      if (i == 0) {
        path.moveTo(
          centerX + outerRadius * math.cos(outerAngle),
          centerY + outerRadius * math.sin(outerAngle),
        );
      } else {
        path.lineTo(
          centerX + outerRadius * math.cos(outerAngle),
          centerY + outerRadius * math.sin(outerAngle),
        );
      }

      path.lineTo(
        centerX + innerRadius * math.cos(innerAngle),
        centerY + innerRadius * math.sin(innerAngle),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
