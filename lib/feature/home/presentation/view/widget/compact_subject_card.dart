import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';

class CompactSubjectCard extends StatelessWidget {
  final SubjectEntity subject;

  const CompactSubjectCard({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final subjectColor = Color(subject.color);
    final progress = _calculateProgress();

    return GestureDetector(
      onTap: () {
        context.read<SubjectCubit>().updateLastAccessed(subject.id);
        context.push(AppRouter.subjectDetailsView, extra: subject);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: subjectColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Subject Icon
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getSubjectIcon(),
                color: subjectColor.withOpacity(0.8),
                size: 24.sp,
              ),
            ),
            widthBox(14),
            // Subject Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: Styles.font16PrimaryColorTextBold(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  heightBox(8),
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getProgressText(),
                            style: Styles.font13GreyBold(context).copyWith(
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: Styles.font13GreyBold(context).copyWith(
                              fontSize: 11.sp,
                              color: subjectColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      heightBox(6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.getCardColorTwo(context),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            subjectColor.withOpacity(0.8),
                          ),
                          minHeight: 5.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widthBox(12),
            // Arrow Icon
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: subjectColor.withOpacity(0.8),
                size: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateProgress() {
    if (subject.resources.isEmpty) return 0.0;

    final resourceTypes = <ResourceType>{};
    for (var resource in subject.resources) {
      resourceTypes.add(resource.type);
    }

    const totalTypes = 3;
    return resourceTypes.length / totalTypes;
  }

  String _getProgressText() {
    final imageCount =
        subject.resources.where((r) => r.type == ResourceType.image).length;
    final pdfCount =
        subject.resources.where((r) => r.type == ResourceType.pdf).length;
    final linkCount = subject.resources
        .where(
          (r) =>
              r.type == ResourceType.youtubeLink ||
              r.type == ResourceType.bookLink,
        )
        .length;

    final parts = <String>[];
    if (imageCount > 0) parts.add('$imageCount images');
    if (pdfCount > 0) parts.add('$pdfCount PDFs');
    if (linkCount > 0) parts.add('$linkCount links');

    if (parts.isEmpty) return 'No resources yet';
    if (parts.length == 1) return parts[0];
    if (parts.length == 2) return '${parts[0]} • ${parts[1]}';
    return '${parts[0]} • ${parts[1]} +${parts.length - 2}';
  }

  IconData _getSubjectIcon() {
    final subjectName = subject.name.toLowerCase();

    if (subjectName.contains('math') || subjectName.contains('رياضيات')) {
      return Icons.calculate_rounded;
    } else if (subjectName.contains('physics') ||
        subjectName.contains('فيزياء')) {
      return Icons.science_rounded;
    } else if (subjectName.contains('chemistry') ||
        subjectName.contains('كيمياء')) {
      return Icons.biotech_rounded;
    } else if (subjectName.contains('biology') ||
        subjectName.contains('أحياء')) {
      return Icons.eco_rounded;
    } else if (subjectName.contains('history') ||
        subjectName.contains('تاريخ')) {
      return Icons.history_edu_rounded;
    } else if (subjectName.contains('language') ||
        subjectName.contains('لغة')) {
      return Icons.translate_rounded;
    } else if (subjectName.contains('computer') ||
        subjectName.contains('حاسب')) {
      return Icons.computer_rounded;
    } else if (subjectName.contains('art') || subjectName.contains('فن')) {
      return Icons.palette_rounded;
    }

    return Icons.book_rounded;
  }
}
