import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resource_card.dart';

class ResourceTypeSection extends StatelessWidget {
  const ResourceTypeSection({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            widthBox(8),
            Text(
              title,
              style: Styles.font16PrimaryColorTextBold(context),
            ),
          ],
        ),
        heightBox(12),
        ...items.map(
          (item) => ResourceCard(
            name: item['name']!,
            subtitle: item['size'] ?? item['duration'],
            iconColor: iconColor,
            icon: icon,
          ),
        ),
      ],
    );
  }
}
