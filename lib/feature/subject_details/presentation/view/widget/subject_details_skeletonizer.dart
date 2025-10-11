import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/lecture_schedule_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/resources_section.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_header_card.dart';

class SubjectDetailsSkeletonizer extends StatelessWidget {
  const SubjectDetailsSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Create dummy lectures for skeleton
    final dummyLectures = [
      const LectureSchedule(
        id: 'skeleton_1',
        day: DayOfWeek.sunday,
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 11, minute: 0),
        location: 'Loading Room',
      ),
      const LectureSchedule(
        id: 'skeleton_2',
        day: DayOfWeek.tuesday,
        startTime: TimeOfDay(hour: 14, minute: 0),
        endTime: TimeOfDay(hour: 16, minute: 0),
        location: 'Loading Hall',
      ),
      const LectureSchedule(
        id: 'skeleton_3',
        day: DayOfWeek.thursday,
        startTime: TimeOfDay(hour: 10, minute: 30),
        endTime: TimeOfDay(hour: 12, minute: 30),
      ),
    ];

    final dummySubject = SubjectEntity(
      id: 'skeleton_id',
      name: 'Loading Subject Name Here',
      code: 'CODE123',
      doctorName: 'Dr. Loading Name Here',
      year: 1,
      semester: 1,
      creditHours: 3,
      notes:
          'This is a loading note text that will be displayed in the skeleton view',
      resources: const [],
      lectures: dummyLectures,
      color: Colors.grey.value,
      createdAt: now,
      updatedAt: now,
      lastAccessedAt: null,
    );

    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          heightBox(10),
          SubjectHeaderCard(
            subjectName: dummySubject.name,
            instructorName: dummySubject.doctorName,
            hours: dummySubject.creditHours,
            onDelete: () {},
          ),
          heightBox(15),
          // Notes Section Skeleton
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                heightBox(12),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    dummySubject.notes,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          heightBox(15),
          // Lecture Schedule Section with dummy data
          LectureScheduleSection(subject: dummySubject),
          heightBox(15),
          ResourcesSection(subject: dummySubject),
          heightBox(20),
        ],
      ),
    );
  }
}
