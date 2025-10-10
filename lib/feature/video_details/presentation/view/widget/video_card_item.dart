import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/helper/youtube_helper.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_info.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_thumbnail.dart';
import 'package:study_box/feature/video_details/presentation/view/video_player_view.dart';

class VideoCardItem extends StatelessWidget {
  const VideoCardItem({super.key, required this.subject});

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    final videoResource = subject.resources.firstWhere(
      (r) =>
          r.type.toString() == 'video' ||
          r.url.contains('youtube.com') ||
          r.url.contains('youtu.be'),
      orElse: () => throw Exception('No video resource found'),
    );

    final thumbnailUrl = YouTubeHelper.getThumbnailUrl(
      videoResource.url,
      quality: ThumbnailQuality.high,
    );

    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(
          VideoPlayerView(
            videoUrl: videoResource.url,
            videoTitle: videoResource.title,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.getCardColorTwo(context),
            width: 2.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                VideoThumbnail(
                  thumbnailUrl: thumbnailUrl,
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 40.r,
                  ),
                ),
              ],
            ),
            VideoInfo(
              title: videoResource.title,
            ),
          ],
        ),
      ),
    );
  }
}
