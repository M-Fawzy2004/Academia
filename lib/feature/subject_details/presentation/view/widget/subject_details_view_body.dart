import 'package:flutter/material.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/header_details_view.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/notes_section_bloc_consumer.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/quick_actions_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resources_section.dart';
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(10),
          const HeaderDetailsView(),
          heightBox(15),
          SubjectHeaderCard(
            subjectName: 'dart and flutter',
            instructorName: 'Mohamed Fawzy',
            hours: 3,
            onDelete: () {},
            onEdit: () {},
          ),
          heightBox(15),
          QuickActionsSection(
            onAiSuggestion: () {},
            onAddReminder: () {
              CustomSnackBar.showInfo(context, 'Soon');
            },
            onAddExternalNote: () {},
          ),
          heightBox(15),
          NotesSectionBlocConsumer(subjectId: widget.subjectId),
          heightBox(15),
          ResourcesSection(
            isExpanded: showResources,
            onToggle: () {
              setState(() {
                showResources = !showResources;
              });
            },
          ),
          heightBox(20),
        ],
      ),
    );
  }
}