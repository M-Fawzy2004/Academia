// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/header_details_view.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_detials_view_body_bloc_builder.dart';

class SubjectDetailsViewBody extends StatefulWidget {
  const SubjectDetailsViewBody({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  State<SubjectDetailsViewBody> createState() => _SubjectDetailsViewBodyState();
}

class _SubjectDetailsViewBodyState extends State<SubjectDetailsViewBody> {
  bool showResources = true;

  @override
  void initState() {
    super.initState();
    // Load subject details
    context.read<SubjectCubit>().getSubjectById(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(10),
          const HeaderDetailsView(),
          heightBox(15),
          SubjectDetialsViewBodyBlocBuilder(
            mounted: mounted,
            subjectId: widget.subjectId,
          ),
        ],
      ),
    );
  }
}

