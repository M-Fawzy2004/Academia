import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/video_details/presentation/manager/cubit/video_player_cubit.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_player_content.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_player_error_widget.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_player_loading_skeletonizer.dart';

class VideoPlayerBlocBuilder extends StatelessWidget {
  const VideoPlayerBlocBuilder({super.key, required this.videoTitle});

  final String videoTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoPlayerLoading) {
            return const VideoPlayerLoadingSkeletonizer();
          }

          if (state is VideoPlayerError) {
            return VideoPlayerErrorWidget(message: state.message);
          }

          if (state is VideoPlayerWithController) {
            return VideoPlayerContent(
              controller: state.controller,
              videoTitle: videoTitle,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
