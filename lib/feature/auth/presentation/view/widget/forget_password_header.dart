import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';

class ForgetPasswordHeader extends StatelessWidget {
  final String title;

  const ForgetPasswordHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Styles.font18MediumPrimaryBold(context),
        ),
        heightBox(20),
        Center(
          child: Image.asset(
            Assets.imagesJpgForgetPassImage,
            height: 200.h,
            width: 200.w,
          ),
        ),
      ],
    );
  }
}
