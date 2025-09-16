import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/courses/presentation/view/widget/add_courses_button.dart';
import 'package:study_box/feature/courses/presentation/view/widget/course_card.dart';
import 'package:study_box/feature/courses/presentation/view/widget/header_section.dart';
import 'package:study_box/feature/courses/presentation/view/widget/quick_stats_card.dart';
import 'package:study_box/feature/courses/presentation/view/widget/study_streak_widget.dart';
import 'package:study_box/feature/courses/presentation/view/widget/upcoming_tasks_widget.dart';
import 'package:study_box/feature/courses/presentation/view/widget/motivational_quote_widget.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Welcome Section
        const SliverToBoxAdapter(
          child: HeaderSection(),
        ),

        // Study Streak Widget
        const SliverToBoxAdapter(
          child: StudyStreakWidget(),
        ),

        SliverToBoxAdapter(child: heightBox(15)),

        // Motivational Quote
        const SliverToBoxAdapter(
          child: MotivationalQuoteWidget(),
        ),

        SliverToBoxAdapter(child: heightBox(20)),

        // Quick Stats Row
        const SliverToBoxAdapter(
          child: QuickStatsCard(),
        ),

        SliverToBoxAdapter(child: heightBox(20)),

        // Upcoming Tasks
        const SliverToBoxAdapter(
          child: UpcomingTasksWidget(),
        ),

        SliverToBoxAdapter(child: heightBox(25)),

        // My Courses Section Header
        SliverToBoxAdapter(
          child: Row(
            children: [
              Text(
                'My Courses',
                style: Styles.font20MediumBold(context),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  IconlyLight.arrow_right_2,
                  size: 16.sp,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  'View All',
                  style: Styles.font13GreyBold(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: heightBox(15)),
        const SliverToBoxAdapter(
          child: AddCoursesButton(),
        ),
        SliverToBoxAdapter(child: heightBox(20)),
        // My Courses
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: const CourseCard(),
              );
            },
            childCount: 5, 
          ),
        ),
        SliverToBoxAdapter(child: heightBox(20)),
      ],
    );
  }
}
