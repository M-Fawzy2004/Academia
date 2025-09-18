import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_state.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/resource_count_badge_widget.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/resources_expand_button_widget.dart';

class ResourcesHeaderWidget extends StatelessWidget {
  final ResourcesLoaded state;
  final bool isArabic;
  final bool isCollapsible;

  const ResourcesHeaderWidget({
    super.key,
    required this.state,
    required this.isArabic,
    required this.isCollapsible,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.folder_outlined,
                color: AppColors.primaryColor,
                size: 20.sp,
              ),
              widthBox(8),
              Text(
                isArabic ? 'المصادر' : 'Resources',
                style: Styles.font15MediumGreyBold(context),
              ),
              if (state.resources.isNotEmpty) ...[
                widthBox(8),
                ResourceCountBadgeWidget(count: state.resources.length),
              ],
            ],
          ),
        ),
        if (isCollapsible)
          ResourcesExpandButtonWidget(isExpanded: state.isExpanded),
      ],
    );
  }
}
