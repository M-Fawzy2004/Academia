import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class PdfFileGridSkeletonizer extends StatelessWidget {
  const PdfFileGridSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
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
      ),
    );
  }
}

class PdfFileCardShimmer extends StatelessWidget {
  const PdfFileCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Bone.icon(
                    size: 30.w,
                  ),
                  heightBox(15),
                  // Preview lines
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Column(
                      children: [
                        const Bone.text(words: 3),
                        SizedBox(height: 4.h),
                        const Bone.text(words: 2),
                        SizedBox(height: 4.h),
                        const Bone.text(words: 3),
                        SizedBox(height: 4.h),
                        const Bone.text(words: 3),
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
          child: Bone.text(
            words: 2,
            fontSize: 14.sp,
          ),
        ),
        heightBox(4),
        // Subtitle placeholder
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Bone.text(
            words: 1,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
