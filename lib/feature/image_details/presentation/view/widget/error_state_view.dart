import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';

class ErrorStateView extends StatelessWidget {
  final String message;

  const ErrorStateView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 70.sp,
            color: AppColors.primaryColor,
          ),
          heightBox(25),
          Text(
            "Please check your internet connection and try again.",
            textAlign: TextAlign.center,
            style: Styles.font16PrimaryColorTextBold(context).copyWith(
              color: Colors.red.shade300,
            ),
          ),
          heightBox(25),
          CustomButton(
            text: 'Retry',
            onPressed: () => context.read<ImageGalleryCubit>().loadImages(),
          ),
        ],
      ),
    );
  }
}
