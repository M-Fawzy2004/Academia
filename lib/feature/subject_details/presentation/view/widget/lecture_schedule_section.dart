import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';

class LectureScheduleSection extends StatelessWidget {
  const LectureScheduleSection({
    super.key,
    required this.subject,
  });

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    if (subject.lectures.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.getCardColorTwo(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15),
            itemCount: subject.lectures.length,
            separatorBuilder: (context, index) => heightBox(10),
            itemBuilder: (context, index) {
              return _buildLectureCard(subject.lectures[index], context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            color: AppColors.primaryColor,
            size: 25.sp,
          ),
          widthBox(10),
          Text(
            'Schedule',
            style: Styles.font16PrimaryColorTextBold(context),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Color(subject.color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${subject.lectures.length} lectures',
              style: Styles.font13GreyBold(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLectureCard(LectureSchedule lecture, BuildContext context) {
    final timeInfo = _formatTime12Hour(lecture.startTime, lecture.endTime);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: 1.5.w,
        ),
      ),
      child: Row(
        children: [
          // Day badge
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.getCardColor(context),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                _getDayShort(lecture.day),
                style: Styles.font15PrimaryColorTextBold(context),
              ),
            ),
          ),
          widthBox(10),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getDayName(lecture.day),
                  style: Styles.font16PrimaryColorTextBold(context),
                ),
                heightBox(5),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    widthBox(5),
                    Text(
                      timeInfo,
                      style: Styles.font13GreyBold(context),
                    ),
                  ],
                ),
                if (lecture.location != null) ...[
                  heightBox(5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: Colors.grey[600],
                      ),
                      widthBox(5),
                      Expanded(
                        child: Text(
                          lecture.location!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 50,
            color: Colors.grey[400],
          ),
          heightBox(13),
          Text(
            'No lectures scheduled',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime12Hour(TimeOfDay start, TimeOfDay end) {
    String formatSingleTime(TimeOfDay time) {
      final hour = time.hour == 0
          ? 12
          : time.hour > 12
              ? time.hour - 12
              : time.hour;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.hour < 12 ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    return '${formatSingleTime(start)} - ${formatSingleTime(end)}';
  }

  String _getDayName(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.saturday:
        return 'Saturday';
      case DayOfWeek.sunday:
        return 'Sunday';
      case DayOfWeek.monday:
        return 'Monday';
      case DayOfWeek.tuesday:
        return 'Tuesday';
      case DayOfWeek.wednesday:
        return 'Wednesday';
      case DayOfWeek.thursday:
        return 'Thursday';
      case DayOfWeek.friday:
        return 'Friday';
    }
  }

  String _getDayShort(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.saturday:
        return 'SAT';
      case DayOfWeek.sunday:
        return 'SUN';
      case DayOfWeek.monday:
        return 'MON';
      case DayOfWeek.tuesday:
        return 'TUE';
      case DayOfWeek.wednesday:
        return 'WED';
      case DayOfWeek.thursday:
        return 'THU';
      case DayOfWeek.friday:
        return 'FRI';
    }
  }
}
