import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class ResourcesContainerWidget extends StatelessWidget {
  final Widget child;

  const ResourcesContainerWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.getFieldColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
      ),
      child: child,
    );
  }
}

class ResourcesExpandableContentWidget extends StatelessWidget {
  final Animation<double> expandAnimation;
  final Widget child;

  const ResourcesExpandableContentWidget({
    super.key,
    required this.expandAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: expandAnimation,
      child: child,
    );
  }
}
