import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/video_details/presentation/manager/cubit/video_player_cubit.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_player_view_body.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
  });

  final String videoUrl;
  final String videoTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerCubit()..initializePlayer(videoUrl),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: VideoPlayerViewBody(
              videoTitle: videoTitle,
            ),
          ),
        ),
      ),
    );
  }
}
