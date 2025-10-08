import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({
    super.key,
    required this.thumbnailUrl,
  });

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 8,
            child: Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.getCardColorTwo(context),
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 48.sp,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.getPrimaryColor(context),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
              ),
            ],
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            color: AppColors.getCardColorTwo(context),
            size: 28.sp,
          ),
        ),
      ],
    );
  }
}
