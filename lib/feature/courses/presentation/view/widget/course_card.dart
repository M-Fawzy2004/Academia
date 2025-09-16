import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  // Sample data - replace with actual course data
  final String courseName = 'Math';
  final String courseCode = 'MATH 101';
  final String description = 'Calculus & Linear Algebra';
  final int progress = 50;
  final int completedLessons = 18;
  final String nextDeadline = '2 days';
  final Color courseColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: courseColor.withOpacity(0.1),
          width: 1.5.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: courseColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.calculate_outlined,
                  color: courseColor,
                  size: 24.sp,
                ),
              ),
              widthBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          courseName,
                          style: Styles.font15MediumBold(context),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: courseColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            courseCode,
                            style:
                                Styles.font12MediumWhiteBold(context).copyWith(
                              color: courseColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox(4),
                    Text(
                      description,
                      style: Styles.font13GreyBold(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          heightBox(16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: Styles.font12MediumWhiteBold(context),
                        ),
                        Text(
                          '$progress%',
                          style: Styles.font12MediumWhiteBold(context).copyWith(
                            color: courseColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    heightBox(6),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: courseColor.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(courseColor),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ],
                ),
              ),
              widthBox(20),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  IconlyBold.arrow_right,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
