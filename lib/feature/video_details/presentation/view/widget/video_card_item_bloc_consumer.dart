import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_card_item.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_card_item_skeletonizer.dart';

class VideoCardItemBlocConsumer extends StatelessWidget {
  const VideoCardItemBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectCubit, SubjectState>(
      listener: (context, state) {
        if (state is SubjectError) {
          CustomSnackBar.showError(context, "Please try again");
        }
      },
      builder: (context, state) {
        if (state is SubjectLoading) {
          return const VideoCardItemSkeletonizer();
        }

        if (state is SubjectLoaded) {
          // Check if there's any video resource (case insensitive)
          final hasVideo = state.subject.resources.any(
            (r) =>
                r.type.toString() == 'video' ||
                r.url.contains('youtube.com') ||
                r.url.contains('youtu.be'),
          );

          if (hasVideo) {
            return VideoCardItem(subject: state.subject);
          }
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No videos found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
