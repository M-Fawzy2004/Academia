import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_control_buttons.dart';

class VideoPlayerContent extends StatelessWidget {
  final YoutubePlayerController controller;
  final String videoTitle;

  const VideoPlayerContent({
    super.key,
    required this.controller,
    required this.videoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: AspectRatio(
              aspectRatio: 16 / 12,
              child: YoutubePlayer(
                controller: controller,
                aspectRatio: 16 / 12,
              ),
            ),
          ),
          heightBox(16),
          Text(
            videoTitle,
            style: TextStyle(
              color: AppColors.getTextColor(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          heightBox(20),
          const VideoControlButtons(),
          heightBox(20),
          _buildVideoInfo(context),
        ],
      ),
    );
  }

  Widget _buildVideoInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video Information',
            style: Styles.font14PrimaryColorTextBold(context),
          ),
          heightBox(12),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.getPrimaryColor(context),
                size: 20.r,
              ),
              widthBox(8),
              Expanded(
                child: Text(
                  'Use the playback controls below to play, pause, or skip forward/backward.',
                  style: Styles.font12GreyBold(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
