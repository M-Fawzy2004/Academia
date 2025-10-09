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
    return ClipRRect(
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
    );
  }
}
