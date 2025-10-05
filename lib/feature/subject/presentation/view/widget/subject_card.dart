import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
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
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: subjectColor.withOpacity(0.6),
          width: 1.2.w,
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
                heightBox(10),
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
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
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
          widthBox(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: Styles.font16PrimaryColorTextBold(context).copyWith(
                    fontSize: 18.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                heightBox(3),
                Text(
                  'Year ${subject.year} • Semester ${subject.semester}',
                  style: Styles.font13GreyBold(context),
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
          'Available Content : ',
          style: Styles.font16PrimaryColorTextBold(context),
        ),
        heightBox(10),
        if (resourcesByType.isEmpty)
          _buildResourceChip(
            'No resources yet',
            subjectColor,
            Icons.info_outline,
            context,
          )
        else
          Wrap(
            spacing: 5.w,
            runSpacing: 10.h,
            children: resourcesByType.entries.map((entry) {
              final info = _getResourceInfo(entry.key);
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: subjectColor.withOpacity(0.8), size: 15.sp),
          widthBox(6),
          Text(
            label,
            style: Styles.font12MediumBold(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenButton(Color subjectColor, BuildContext context) {
    return CustomButton(
      height: 45.h,
      borderRadius: 12.r,
      text: 'Open Subject',
      backgroundColor: subjectColor.withOpacity(0.8),
      onPressed: () {
        context.read<SubjectCubit>().updateLastAccessed(subject.id);
        context.push(AppRouter.subjectDetailsView, extra: subject);
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

  Map<String, dynamic> _getResourceInfo(ResourceType type) {
    switch (type) {
      case ResourceType.image:
        return {'label': 'Images', 'icon': Icons.image_rounded};
      case ResourceType.pdf:
        return {'label': 'PDF Summaries', 'icon': Icons.picture_as_pdf_rounded};
      case ResourceType.youtubeLink:
        return {
          'label': 'Video Lectures',
          'icon': Icons.play_circle_fill_rounded
        };
      case ResourceType.bookLink:
        return {'label': 'Textbook', 'icon': Icons.menu_book_rounded};
      case ResourceType.record:
        return {
          'label': 'Past Exams',
          'icon': Icons.assignment_turned_in_rounded
        };
    }
  }
}
