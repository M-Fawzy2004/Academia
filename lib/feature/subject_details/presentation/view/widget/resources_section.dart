import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/pdf_details/presentation/view/pdf_detials_view.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resource_type_card.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart'
    as domain;
import 'package:study_box/feature/video_details/presentation/view/video_details_view.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({super.key, required this.subject});

  final domain.SubjectEntity subject;

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
          count: subject.resources
              .where((r) => r.type == domain.ResourceType.pdf)
              .length,
          items: subject.resources
              .where((r) => r.type == domain.ResourceType.pdf)
              .map((r) => {
                    'name': r.title,
                    'url': r.url,
                    'size': (r.fileSizeMB ?? 0).toString(),
                  })
              .toList(),
          onViewAll: () {
            context.navigateWithSlideTransition(
              PdfDetialsView(subjectId: subject.id),
            );
          },
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Book Links',
          icon: Icons.menu_book_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          ),
          count: subject.resources
              .where((r) => r.type == domain.ResourceType.bookLink)
              .length,
          items: subject.resources
              .where((r) => r.type == domain.ResourceType.bookLink)
              .map((r) => {
                    'name': r.title,
                    'url': r.url,
                  })
              .toList(),
          onViewAll: () {},
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Video Links',
          icon: Icons.play_circle_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFA855F7), Color(0xFF9333EA)],
          ),
          count: subject.resources
              .where((r) => r.type == domain.ResourceType.youtubeLink)
              .length,
          items: subject.resources
              .where((r) => r.type == domain.ResourceType.youtubeLink)
              .map((r) => {
                    'name': r.title,
                    'url': r.url,
                  })
              .toList(),
          onViewAll: () {
            context.navigateWithSlideTransition(
              VideoDetailsView(subjectId: subject.id),
            );
          },
        ),
        heightBox(12),
        ResourceTypeCard(
          title: 'Images',
          icon: Icons.image_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          count: subject.resources
              .where((r) => r.type == domain.ResourceType.image)
              .length,
          items: subject.resources
              .where((r) => r.type == domain.ResourceType.image)
              .map((r) => {
                    'name': r.title,
                    'url': r.url,
                  })
              .toList(),
          onViewAll: () {},
        ),
      ],
    );
  }
}
