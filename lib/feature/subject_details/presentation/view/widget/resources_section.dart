import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resource_type_section.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  final bool isExpanded;
  final VoidCallback onToggle;

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
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.folder_outlined,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  widthBox(12),
                  Text(
                    'Resources',
                    style: Styles.font18PrimaryColorTextBold(context),
                  ),
                  const Spacer(),
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
          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResourceTypeSection(
                    title: 'PDF',
                    icon: Icons.picture_as_pdf_rounded,
                    iconColor: Color(0xFFEF4444),
                    items: [
                      {'name': 'شرح الفصل الأول.pdf', 'size': '2.5 MB'},
                      {'name': 'ملخص المنهج.pdf', 'size': '1.8 MB'},
                    ],
                  ),
                  heightBox(20),
                  const ResourceTypeSection(
                    title: 'Link Book',
                    icon: Icons.link_rounded,
                    iconColor: Color(0xFF3B82F6),
                    items: [
                      {'name': 'كتاب المادة الرسمي'},
                      {'name': 'مصادر إضافية'},
                    ],
                  ),
                  heightBox(20),
                  const ResourceTypeSection(
                    title: 'Links Video',
                    icon: Icons.play_circle_outline_rounded,
                    iconColor: Color(0xFFA855F7),
                    items: [
                      {'name': 'شرح المحاضرة الأولى', 'duration': '45:30'},
                      {'name': 'شرح المحاضرة الثانية', 'duration': '52:15'},
                    ],
                  ),
                  heightBox(20),
                  const ResourceTypeSection(
                    title: 'Images',
                    icon: Icons.image_outlined,
                    iconColor: Color(0xFF10B981),
                    items: [
                      {'name': 'رسم توضيحي 1'},
                      {'name': 'رسم توضيحي 2'},
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
