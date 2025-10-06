import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/domain/entities/additional_note_entity.dart';
import 'package:study_box/feature/subject_details/presentation/manager/cubit/additional_notes_cubit.dart';

class EditNoteDialog extends StatefulWidget {
  final String subjectId;
  final AdditionalNote note;

  const EditNoteDialog({
    super.key,
    required this.subjectId,
    required this.note,
  });

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _detailsController = TextEditingController(text: widget.note.details);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _handleUpdateNote() {
    if (_formKey.currentState!.validate()) {
      context.read<AdditionalNotesCubit>().updateNote(
            noteId: widget.note.id,
            subjectId: widget.subjectId,
            title: _titleController.text.trim(),
            details: _detailsController.text.trim(),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.getCardColorTwo(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.edit_note_outlined,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  widthBox(12),
                  Text(
                    'Edit Note',
                    style: Styles.font18PrimaryColorTextBold(context),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 24.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              heightBox(20),
              Text(
                'Title',
                style: Styles.font13GreyBold(context),
              ),
              heightBox(8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter note title',
                  filled: true,
                  fillColor: AppColors.getCardColor(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              heightBox(16),
              Text(
                'Details',
                style: Styles.font13GreyBold(context),
              ),
              heightBox(8),
              TextFormField(
                controller: _detailsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter note details',
                  filled: true,
                  fillColor: AppColors.getCardColor(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              heightBox(24),
              ElevatedButton(
                onPressed: _handleUpdateNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Update Note',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showEditNoteDialog(
  BuildContext context,
  String subjectId,
  AdditionalNote note,
) {
  showDialog(
    context: context,
    builder: (context) => EditNoteDialog(
      subjectId: subjectId,
      note: note,
    ),
  );
}