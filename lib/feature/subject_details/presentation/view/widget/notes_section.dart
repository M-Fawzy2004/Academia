import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/subject_details/domain/entities/additional_note_entity.dart';
import 'package:study_box/feature/subject_details/presentation/manager/cubit/additional_notes_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/add_note_dialog.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/note_card.dart';

class NotesSection extends StatefulWidget {
  const NotesSection({
    super.key,
    required this.notes,
    required this.subjectId,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<AdditionalNote> notes;
  final String subjectId;
  final bool isLoading;
  final String? errorMessage;

  @override
  State<NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  widthBox(12),
                  Text(
                    'Notes',
                    style: Styles.font18PrimaryColorTextBold(context),
                  ),
                  widthBox(10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${widget.notes.length}',
                      style: TextStyle(
                        color: const Color(0xFF6366F1),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () =>
                        showAddNoteDialog(context, widget.subjectId),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF9CA3AF),
                    size: 28.sp,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildExpandedContent(context),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    if (widget.isLoading) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: const Center(
          child: CustomLoadingWidget(),
        ),
      );
    }

    if (widget.errorMessage != null) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48.sp,
              ),
              heightBox(12),
              Text(
                CustomSnackBar.formatForBuild(widget.errorMessage!),
                style: Styles.font13GreyBold(context),
                textAlign: TextAlign.center,
              ),
              heightBox(12),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AdditionalNotesCubit>()
                      .loadNotes(widget.subjectId);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.notes.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.note_add_outlined,
                color: const Color(0xFF9CA3AF),
                size: 48.sp,
              ),
              heightBox(12),
              Text(
                'No notes yet',
                style: Styles.font13GreyBold(context),
              ),
              heightBox(8),
              Text(
                'Add your first note to get started',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: widget.notes
          .map(
            (note) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
              child: NoteCard(
                note: note,
                subjectId: widget.subjectId,
              ),
            ),
          )
          .toList(),
    );
  }
}
