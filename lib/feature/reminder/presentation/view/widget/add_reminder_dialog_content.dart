import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/cubit/dialog_animation/dialog_animation_cubit.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/manager/add_reminder_form_cubit/add_reminder_form_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_date_time_picker.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_selector.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_priority_selector.dart';

class AddReminderDialogContent extends StatefulWidget {
  final ReminderEntity? reminder;

  const AddReminderDialogContent({
    super.key,
    this.reminder,
  });

  @override
  State<AddReminderDialogContent> createState() =>
      _AddReminderDialogContentState();
}

class _AddReminderDialogContentState extends State<AddReminderDialogContent>
    with SingleTickerProviderStateMixin {
  late DialogAnimationCubit animationCubit;

  @override
  void initState() {
    super.initState();
    animationCubit = DialogAnimationCubit(vsync: this);
  }

  @override
  void dispose() {
    animationCubit.close();
    super.dispose();
  }

  void saveReminder(BuildContext context) {
    final formCubit = context.read<AddReminderFormCubit>();
    final reminderCubit = context.read<ReminderCubit>();

    final validationError = formCubit.validateTitle();
    if (validationError != null) {
      CustomSnackBar.showError(context, validationError);
      return;
    }

    final reminderEntity = formCubit.buildReminderEntity(widget.reminder);

    if (widget.reminder != null) {
      reminderCubit.updateReminder(reminderEntity);
    } else {
      reminderCubit.addReminder(reminderEntity);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final formCubit = context.read<AddReminderFormCubit>();

    return BlocBuilder<DialogAnimationCubit, DialogAnimationState>(
      bloc: animationCubit,
      builder: (context, animationState) {
        return FadeTransition(
          opacity: animationState.fadeAnimation,
          child: ScaleTransition(
            scale: animationState.scaleAnimation,
            child: Dialog(
              backgroundColor: AppColors.getBackgroundColor(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            widget.reminder != null
                                ? IconlyBold.edit
                                : IconlyBold.plus,
                            color: AppColors.primaryColor,
                            size: 24.sp,
                          ),
                          widthBox(8),
                          Text(
                            widget.reminder != null
                                ? 'Edit Reminder'
                                : 'Add Reminder',
                            style: Styles.font16PrimaryColorTextBold(context),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      heightBox(20),
                      CustomTextField(
                        controller: formCubit.titleController,
                        hintText: 'Enter title',
                      ),
                      heightBox(16),
                      CustomTextField(
                        maxLines: 3,
                        controller: formCubit.descriptionController,
                        hintText: 'Enter details',
                      ),
                      heightBox(16),
                      Text('Type', style: Styles.font13GreyBold(context)),
                      heightBox(8),
                      const ReminderTypeSelector(),
                      heightBox(16),
                      Text('Priority', style: Styles.font13GreyBold(context)),
                      heightBox(8),
                      const ReminderPrioritySelector(),
                      heightBox(16),
                      const ReminderDateTimePicker(),
                      heightBox(16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              backgroundColor:
                                  AppColors.getCardColorTwo(context),
                              textColor: AppColors.getTextPrimaryColor(context),
                              fontSize: 14.sp,
                              height: 45.h,
                              text: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          widthBox(12),
                          Expanded(
                            child: CustomButton(
                              height: 45.h,
                              text: widget.reminder != null ? 'Update' : 'Save',
                              onPressed: () => saveReminder(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}