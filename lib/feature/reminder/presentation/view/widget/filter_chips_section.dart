import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class FilterChipsSection extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterChipsSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['all', 'subject', 'task', 'custom'];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (context, index) => widthBox(10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected =
              selectedFilter.toLowerCase() == filter.toLowerCase();

          String displayLabel = '';
          switch (filter) {
            case 'all':
              displayLabel = 'All';
              break;
            case 'subject':
              displayLabel = 'Subjects';
              break;
            case 'task':
              displayLabel = 'Tasks';
              break;
            case 'custom':
              displayLabel = 'Custom';
              break;
          }

          return FilterChip(
            label: Text(displayLabel),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                onFilterChanged(filter);
              }
            },
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide.none,
            ),
            backgroundColor: AppColors.getCardColorTwo(context),
            selectedColor: AppColors.primaryColor.withOpacity(0.15),
            checkmarkColor: AppColors.primaryColor,
            labelStyle: TextStyle(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.getTextPrimaryColor(context),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
            ),
          );
        },
      ),
    );
  }
}
