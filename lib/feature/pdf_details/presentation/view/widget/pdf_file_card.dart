import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class PdfFileCard extends StatelessWidget {
  final String fileName;
  final String subtitle;

  const PdfFileCard({
    super.key,
    required this.fileName,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.getCardColorTwo(context),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  color: AppColors.getCardColorTwo(context),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf_rounded,
                          size: 30.sp,
                          color: Colors.red.shade400,
                        ),
                        heightBox(15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Column(
                            children: [
                              _buildPreviewLine(0.85),
                              SizedBox(height: 4.h),
                              _buildPreviewLine(0.65),
                              SizedBox(height: 4.h),
                              _buildPreviewLine(0.8),
                              SizedBox(height: 4.h),
                              _buildPreviewLine(0.8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          heightBox(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              fileName,
              style: Styles.font15PrimaryColorTextBold(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          heightBox(4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              subtitle,
              style: Styles.font13GreyBold(context).copyWith(
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewLine(double widthFactor) {
    return Container(
      width: double.infinity,
      height: 2.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }
}
