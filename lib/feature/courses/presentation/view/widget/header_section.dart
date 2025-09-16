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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: Styles.font15MediumBold(context),
                ),
                heightBox(5),
                Text(
                  'Ready to continue learning?',
                  style: Styles.font13GreyBold(context),
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(IconlyLight.notification),
                color: AppColors.secondaryColor,
              ),
            ),
            widthBox(8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {},
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
