import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/manager/cubit/additional_notes_cubit.dart';

class AddNoteDialog extends StatefulWidget {
  final String subjectId;

  const AddNoteDialog({
    super.key,
    required this.subjectId,
  });

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _handleAddNote() {
    if (_formKey.currentState!.validate()) {
      context.read<AdditionalNotesCubit>().addNote(
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
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.note_add_outlined,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  widthBox(12),
                  Text(
                    'Add Note',
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

              // Title Field
              Text(
                'Title',
                style: Styles.font13GreyBold(context),
              ),
              heightBox(8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter note title',
                  hintStyle: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
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

              // Details Field
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
                  hintStyle: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
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

              // Add Button
              ElevatedButton(
                onPressed: _handleAddNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Add Note',
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

// Helper function to show the dialog
void showAddNoteDialog(BuildContext context, String subjectId) {
  showDialog(
    context: context,
    builder: (context) => AddNoteDialog(subjectId: subjectId),
  );
}