import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/action_button.dart';

class SubjectHeaderCard extends StatelessWidget {
  const SubjectHeaderCard({
    super.key,
    required this.subjectName,
    required this.instructorName,
    required this.hours,
    required this.onDelete,
  });

  final String subjectName;
  final String instructorName;
  final int hours;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: Styles.font20PrimaryColorTextBold(context),
                    ),
                    heightBox(10),
                    Row(
                      children: [
                        Icon(
                          IconlyLight.profile,
                          size: 18.sp,
                          color: const Color(0xFF6B7280),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          instructorName,
                          style: Styles.font13GreyBold(context),
                        ),
                      ],
                    ),
                    heightBox(10),
                    Row(
                      children: [
                        Icon(
                          IconlyLight.time_circle,
                          size: 18.sp,
                          color: const Color(0xFF6B7280),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '$hours Hours',
                          style: Styles.font13GreyBold(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              ActionButton(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFEF4444),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
