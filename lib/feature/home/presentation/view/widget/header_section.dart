import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: Styles.font20MediumBold(context),
                  ),
                  heightBox(2),
                  Text(
                    'Ready to continue learning?',
                    style: Styles.font13GreyBold(context),
                  ),
                ],
              ),
            ),
            // Notifications Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {
                  // Handle notifications
                },
                icon: Stack(
                  children: [
                    const Icon(IconlyLight.notification),
                    // Notification badge
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                color: AppColors.secondaryColor,
              ),
            ),
            widthBox(8),
            // Search Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {
                  // Handle search
                },
                icon: const Icon(IconlyLight.search),
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        heightBox(20),
      ],
    );
  }
}
