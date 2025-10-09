import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/name_header_video.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_player_bloc_builder.dart';

class VideoPlayerViewBody extends StatelessWidget {
  const VideoPlayerViewBody({
    super.key,
    required this.videoTitle,
  });

  final String videoTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(10),
        NameHeaderVideo(videoTitle: videoTitle),
        heightBox(10),
        VideoPlayerBlocBuilder(videoTitle: videoTitle),
      ],
    );
  }
}
