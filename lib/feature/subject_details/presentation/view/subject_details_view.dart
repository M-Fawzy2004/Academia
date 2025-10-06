import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/subject_details/presentation/manager/cubit/additional_notes_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_details_view_body.dart';

class SubjectDetailsView extends StatefulWidget {
  const SubjectDetailsView({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  State<SubjectDetailsView> createState() => _SubjectDetailsViewState();
}

class _SubjectDetailsViewState extends State<SubjectDetailsView> {
  @override
  void initState() {
    super.initState();
    // Load notes when view opens
    context.read<AdditionalNotesCubit>().loadNotes(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SubjectDetailsViewBody(subjectId: widget.subjectId),
        ),
      ),
    );
  }
}