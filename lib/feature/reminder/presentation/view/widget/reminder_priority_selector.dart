import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/presentation/manager/add_reminder_form_cubit/add_reminder_form_cubit.dart';

class ReminderPrioritySelector extends StatelessWidget {
  const ReminderPrioritySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReminderFormCubit, AddReminderFormState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _PriorityOption(
                priority: ReminderPriority.high,
                label: 'High',
                icon: Icons.priority_high,
                color: Colors.red,
                isSelected: state.selectedPriority == ReminderPriority.high,
                onTap: () => context
                    .read<AddReminderFormCubit>()
                    .updatePriority(ReminderPriority.high),
              ),
            ),
            widthBox(12),
            Expanded(
              child: _PriorityOption(
                priority: ReminderPriority.medium,
                label: 'Medium',
                icon: Icons.remove,
                color: Colors.orange,
                isSelected: state.selectedPriority == ReminderPriority.medium,
                onTap: () => context
                    .read<AddReminderFormCubit>()
                    .updatePriority(ReminderPriority.medium),
              ),
            ),
            widthBox(12),
            Expanded(
              child: _PriorityOption(
                priority: ReminderPriority.low,
                label: 'Low',
                icon: Icons.low_priority,
                color: Colors.green,
                isSelected: state.selectedPriority == ReminderPriority.low,
                onTap: () => context
                    .read<AddReminderFormCubit>()
                    .updatePriority(ReminderPriority.low),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PriorityOption extends StatelessWidget {
  final ReminderPriority priority;
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityOption({
    required this.priority,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.15)
              : AppColors.getCardColorTwo(context),
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 24.sp),
            heightBox(4),
            Text(
              label,
              style: Styles.font12GreyBold(context).copyWith(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
