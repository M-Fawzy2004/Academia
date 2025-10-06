import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/header_details_view.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart' as domain;
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
              if (state is SubjectLoaded) {
                final s = state.subject;
                return SubjectHeaderCard(
                  subjectName: s.name,
                  instructorName: s.doctorName,
                  hours: s.creditHours,
                  onDelete: () async {
                    await context.read<SubjectCubit>().deleteSubject(s.id);
                    if (mounted) Navigator.of(context).pop();
                  },
                  onEdit: () => _showEditSubjectDialog(context, s),
                );
              }
              return const SizedBox.shrink();
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
          BlocBuilder<SubjectCubit, SubjectState>(
            builder: (context, state) {
              if (state is SubjectLoading) {
                return SizedBox(
                  height: 300.h,
                  child: const CustomLoadingWidget(),
                );
              }
              if (state is SubjectLoaded) {
                return ResourcesSection(subject: state.subject);
              }
              return const SizedBox.shrink();
            },
          ),
          heightBox(20),
        ],
      ),
    );
  }

  void _showEditSubjectDialog(BuildContext context, domain.SubjectEntity subject) {
    final nameController = TextEditingController(text: subject.name);
    final drController = TextEditingController(text: subject.doctorName);
    final hoursController = TextEditingController(text: subject.creditHours.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Subject'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Subject name')),
            TextField(controller: drController, decoration: const InputDecoration(labelText: 'Instructor')),
            TextField(controller: hoursController, decoration: const InputDecoration(labelText: 'Credit hours'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final hours = int.tryParse(hoursController.text.trim());
              if (hours == null) { Navigator.pop(context); return; }
              final updated = subject.copyWith(
                name: nameController.text.trim(),
                doctorName: drController.text.trim(),
                creditHours: hours,
                updatedAt: DateTime.now(),
              );
              await context.read<SubjectCubit>().updateSubject(updated);
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
