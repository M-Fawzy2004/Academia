import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:study_box/core/theme/app_color.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? height;
  final Color? color;

  const CustomLoadingWidget({
    super.key,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height ?? 20.h;
    final Color effectiveColor = color ?? AppColors.primaryColor;
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: effectiveColor,
        size: effectiveHeight,
      ),
    );
  }
}
