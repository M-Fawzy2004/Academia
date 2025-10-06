// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/header_details_view.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/notes_section_bloc_consumer.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/quick_actions_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resources_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_details_shimmer.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_header_card.dart';

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
          BlocBuilder<SubjectCubit, SubjectState>(
            builder: (context, state) {
              if (state is SubjectLoading) {
                return const SubjectDetailsShimmer();
              }
              if (state is SubjectLoaded) {
                final s = state.subject;
                return Column(
                  children: [
                    SubjectHeaderCard(
                      subjectName: s.name,
                      instructorName: s.doctorName,
                      hours: s.creditHours,
                      onDelete: () async {
                        await context.read<SubjectCubit>().deleteSubject(s.id);
                        if (mounted) Navigator.of(context).pop();
                      },
                    ),
                    heightBox(15),
                    QuickActionsSection(
                      onAiSuggestion: () {
                        CustomSnackBar.showInfo(context, 'Soon');
                      },
                      onAddReminder: () {
                        CustomSnackBar.showInfo(context, 'Soon');
                      },
                    ),
                    heightBox(15),
                    NotesSectionBlocConsumer(subjectId: widget.subjectId),
                    heightBox(15),
                    ResourcesSection(subject: s),
                    heightBox(20),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
