import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/home/presentation/manager/connection/courses_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/add_courses_button.dart';
import 'package:study_box/feature/home/presentation/view/widget/subject_card.dart';
import 'package:study_box/feature/home/presentation/view/widget/header_section.dart';
import 'package:study_box/feature/home/presentation/view/widget/subjects_header.dart';
import 'package:study_box/feature/home/presentation/view/widget/quick_stats_card.dart';
import 'package:study_box/feature/home/presentation/view/widget/study_streak_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/upcoming_tasks_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/motivational_quote_widget.dart';

class HomeViewBody extends StatelessWidget {
  final List<dynamic> courses;
  final Map<String, dynamic> userData;

  const HomeViewBody({
    super.key,
    required this.courses,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: AppColors.getNavigationBar(context),
      onRefresh: () async {
        context.read<CoursesCubit>().loadCourses();
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: HeaderSection(),
          ),
          const SliverToBoxAdapter(
            child: StudyStreakWidget(),
          ),
          SliverToBoxAdapter(child: heightBox(15)),
          const SliverToBoxAdapter(
            child: MotivationalQuoteWidget(),
          ),
          SliverToBoxAdapter(child: heightBox(20)),
          const SliverToBoxAdapter(
            child: QuickStatsCard(),
          ),
          SliverToBoxAdapter(child: heightBox(20)),
          const SliverToBoxAdapter(
            child: UpcomingTasksWidget(),
          ),
          SliverToBoxAdapter(child: heightBox(25)),
          const SliverToBoxAdapter(
            child: SubjectsHeader(),
          ),
          SliverToBoxAdapter(child: heightBox(15)),
          const SliverToBoxAdapter(
            child: AddCoursesButton(),
          ),
          SliverToBoxAdapter(child: heightBox(20)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: const SubjectCard(),
                );
              },
              childCount: courses.length,
            ),
          ),
          SliverToBoxAdapter(child: heightBox(20)),
        ],
      ),
    );
  }
}
