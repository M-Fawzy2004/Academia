import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/feature/video_details/presentation/manager/cubit/video_player_cubit.dart';

class VideoControlButtons extends StatelessWidget {
  const VideoControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Playback Controls',
            style: TextStyle(
              color: AppColors.getTextColor(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          heightBox(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                context,
                icon: Icons.replay_10_rounded,
                label: '-10s',
                onTap: () {
                  context.read<VideoPlayerCubit>().seekBackward();
                },
              ),
              BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                builder: (context, state) {
                  final isPlaying = state is VideoPlayerPlaying;
                  final isLoading = state is VideoPlayerLoading;

                  if (isLoading) {
                    return _buildControlButton(
                      context,
                      icon: Icons.play_circle_filled_rounded,
                      label: 'Loading...',
                      onTap: null,
                    );
                  }

                  return _buildControlButton(
                    context,
                    icon: isPlaying
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_filled_rounded,
                    label: isPlaying ? 'Pause' : 'Play',
                    onTap: () {
                      context.read<VideoPlayerCubit>().togglePlayPause();
                    },
                  );
                },
              ),
              _buildControlButton(
                context,
                icon: Icons.forward_10_rounded,
                label: '+10s',
                onTap: () {
                  context.read<VideoPlayerCubit>().seekForward();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.getPrimaryColor(context)
              .withOpacity(isDisabled ? 0.05 : 0.1),
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: AppColors.getPrimaryColor(context)
                .withOpacity(isDisabled ? 0.1 : 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.getPrimaryColor(context)
                  .withOpacity(isDisabled ? 0.5 : 1.0),
              size: 28.r,
            ),
            heightBox(4),
            Text(
              label,
              style: TextStyle(
                color: AppColors.getTextColor(context)
                    .withOpacity(isDisabled ? 0.5 : 1.0),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
