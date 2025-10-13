import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/subject_details/presentation/manager/additional_note_cubit/additional_notes_cubit.dart';

class AddNoteDialog extends StatefulWidget {
  final String subjectId;

  const AddNoteDialog({
    super.key,
    required this.subjectId,
  });

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          backgroundColor: AppColors.getBackgroundColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                          context.tr.add_note,
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
                      context.tr.title,
                      style: Styles.font13GreyBold(context),
                    ),
                    heightBox(8),
                    CustomTextField(
                      controller: _titleController,
                      hintText: context.tr.hint_text_title,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.tr.required_note_title;
                        }
                        return null;
                      },
                    ),
                    heightBox(16),
                    // Details Field
                    Text(
                      context.tr.details,
                      style: Styles.font13GreyBold(context),
                    ),
                    heightBox(8),
                    CustomTextField(
                      controller: _detailsController,
                      maxLines: 5,
                      hintText: context.tr.hint_text_details,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.tr.required_note_details;
                        }
                        return null;
                      },
                    ),
                    heightBox(24),
                    CustomButton(
                      text: context.tr.add_note,
                      onPressed: _handleAddNote,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
void showAddNoteDialog(BuildContext context, String subjectId) {
  final existingCubit = context.read<AdditionalNotesCubit>();
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (dialogContext) => BlocProvider.value(
      value: existingCubit,
      child: AddNoteDialog(subjectId: subjectId),
    ),
  );
}
