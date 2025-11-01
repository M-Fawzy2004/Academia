import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';

class SubjectCard extends StatelessWidget {
  final SubjectEntity subject;

  const SubjectCard({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final subjectColor = Color(subject.color);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: subjectColor,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: subjectColor.withOpacity(0.4),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(subjectColor, context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox(5),
                _buildAvailableContent(subjectColor, context),
                heightBox(13),
                _buildOpenButton(subjectColor, context),
                heightBox(10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(Color subjectColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.large),
          topRight: Radius.circular(AppRadius.large),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  subjectColor.withOpacity(0.9),
                  subjectColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              _getSubjectIcon(),
              color: Colors.white,
              size: 26.sp,
            ),
          ),
          widthBox(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: Styles.font14PrimaryColorTextBold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                heightBox(3),
                Text(
                  '${context.tr.year_title} ${subject.year} • ${context.tr.semester_title}  ${subject.semester}',
                  style: Styles.font12GreyBold(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableContent(Color subjectColor, BuildContext context) {
    final resourcesByType = <ResourceType, int>{};
    for (var resource in subject.resources) {
      resourcesByType[resource.type] =
          (resourcesByType[resource.type] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.available,
          style: Styles.font14PrimaryColorTextBold(context),
        ),
        heightBox(10),
        if (resourcesByType.isEmpty)
          _buildResourceChip(
            context.tr.no_resources,
            subjectColor,
            Icons.info_outline,
            context,
          )
        else
          Wrap(
            spacing: 5.w,
            runSpacing: 10.h,
            children: resourcesByType.entries.map((entry) {
              final info = _getResourceInfo(entry.key, context);
              return _buildResourceChip(
                info['label'],
                subjectColor,
                info['icon'],
                context,
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildResourceChip(
    String label,
    Color subjectColor,
    IconData icon,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: subjectColor.withOpacity(0.8), size: 15.sp),
          widthBox(6),
          Text(
            label,
            style: Styles.font11MediumBold(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenButton(Color subjectColor, BuildContext context) {
    return CustomButton(
      height: 40.h,
      text: context.tr.open_subject,
      backgroundColor: subjectColor.withOpacity(0.8),
      onPressed: () {
        context.read<SubjectCubit>().updateLastAccessed(subject.id);
        context.push('${AppRouter.subjectDetailsView}?subjectId=${subject.id}');
      },
    );
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

  Map<String, dynamic> _getResourceInfo(
      ResourceType type, BuildContext context) {
    switch (type) {
      case ResourceType.image:
        return {
          'label': context.tr.image,
          'icon': Icons.image_rounded,
        };
      case ResourceType.pdf:
        return {
          'label': context.tr.pdf_summaries,
          'icon': Icons.picture_as_pdf_rounded,
        };
      case ResourceType.youtubeLink:
        return {
          'label': context.tr.video_lecture,
          'icon': Icons.play_circle_fill_rounded,
        };
      case ResourceType.bookLink:
        return {
          'label': context.tr.text_book,
          'icon': Icons.menu_book_rounded,
        };
      case ResourceType.record:
        return {
          'label': context.tr.past_exam,
          'icon': Icons.assignment_turned_in_rounded,
        };
    }
  }
}
