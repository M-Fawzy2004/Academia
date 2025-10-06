import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resource_type_card.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.folder_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              widthBox(12),
              Text(
                'Resources',
                style: Styles.font18PrimaryColorTextBold(context),
              ),
            ],
          ),
        ),
        heightBox(16),
        ResourceTypeCard(
          title: 'PDF Documents',
          icon: Icons.picture_as_pdf_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          ),
          count: 5,
          items: const [
            {'name': 'شرح الفصل الأول.pdf', 'size': '2.5 MB'},
            {'name': 'ملخص المنهج.pdf', 'size': '1.8 MB'},
          ],
          onViewAll: () {},
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Link Books',
          icon: Icons.menu_book_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          ),
          count: 3,
          items: const [
            {'name': 'كتاب المادة الرسمي'},
            {'name': 'مصادر إضافية'},
          ],
          onViewAll: () {},
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Video Lectures',
          icon: Icons.play_circle_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFA855F7), Color(0xFF9333EA)],
          ),
          count: 8,
          items: const [
            {'name': 'شرح المحاضرة الأولى', 'duration': '45:30'},
            {'name': 'شرح المحاضرة الثانية', 'duration': '52:15'},
          ],
          onViewAll: () {},
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Images',
          icon: Icons.image_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          count: 12,
          items: const [
            {'name': 'رسم توضيحي 1'},
            {'name': 'رسم توضيحي 2'},
          ],
          onViewAll: () {},
        ),
      ],
    );
  }
}
