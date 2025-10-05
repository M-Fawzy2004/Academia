import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/icon_back.dart';

class HeaderDetailsView extends StatelessWidget {
  const HeaderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IconBack(),
        const Spacer(),
        Text(
          'Subject Details',
          style: Styles.font20PrimaryColorTextBold(context),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            IconlyLight.send,
            color: AppColors.primaryColor,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}
