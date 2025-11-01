import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final double? height;

  const SettingsCard({super.key, required this.children, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.large),
        color: AppColors.getCardColorTwo(context),
      ),
      child: Column(children: children),
    );
  }
}
