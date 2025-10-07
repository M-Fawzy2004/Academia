import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class PdfFileGridShimmer extends StatelessWidget {
  const PdfFileGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 25.h,
          childAspectRatio: 0.67,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const PdfFileCardShimmer();
        },
      ),
    );
  }
}

class PdfFileCardShimmer extends StatelessWidget {
  const PdfFileCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.getCardColorTwo(context),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // PDF Icon placeholder
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    heightBox(15),
                    // Preview lines
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                          _buildShimmerLine(0.85),
                          SizedBox(height: 4.h),
                          _buildShimmerLine(0.65),
                          SizedBox(height: 4.h),
                          _buildShimmerLine(0.8),
                          SizedBox(height: 4.h),
                          _buildShimmerLine(0.8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          heightBox(10),
          // File name placeholder
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Container(
              width: double.infinity,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          heightBox(4),
          // Subtitle placeholder
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Container(
              width: 50.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLine(double widthFactor) {
    return Container(
      width: double.infinity,
      height: 2.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }
}