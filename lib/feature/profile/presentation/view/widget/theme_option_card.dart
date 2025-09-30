import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_icon_container.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_selection_indicator.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_text_content.dart';

class ThemeOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColors.getCardColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.getBorderColor(context),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Row(
          children: [
            ThemeIconContainer(
              icon: icon,
              gradient: gradient,
            ),
            widthBox(15),
            Expanded(
              child: ThemeTextContent(
                title: title,
                subtitle: subtitle,
              ),
            ),
            ThemeSelectionIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
