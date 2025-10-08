import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_card_item_bloc_consumer.dart';
import 'package:study_box/feature/video_details/presentation/view/widget/video_details_header.dart';

class VideoDetailsViewBody extends StatefulWidget {
  const VideoDetailsViewBody({super.key, required this.subjectId});
  
  final String subjectId;

  @override
  State<VideoDetailsViewBody> createState() => _VideoDetailsViewBodyState();
}

class _VideoDetailsViewBodyState extends State<VideoDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    // Load subject to get PDF files
    context.read<SubjectCubit>().getSubjectById(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(10),
          const VideoDetailsHeader(),
          heightBox(20),
          const VideoCardItemBlocConsumer(),
        ],
      ),
    );
  }
}

