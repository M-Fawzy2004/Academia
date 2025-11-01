import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/icon_back.dart';

class ImageDetailsHeader extends StatelessWidget {
  final VoidCallback? onAddImages;

  const ImageDetailsHeader({
    super.key,
    this.onAddImages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        const IconBack(),
        // Title
        Text(
          context.tr.image_details,
          style: Styles.font16PrimaryColorTextBold(context),
        ),
        // Add button
        GestureDetector(
          onTap: onAddImages,
          child: Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: AppColors.getCardColorTwo(context),
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
            child: const Icon(
              Icons.add_photo_alternate,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
