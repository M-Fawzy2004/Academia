import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/home/presentation/manager/connection/courses_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/header_section.dart';
import 'package:study_box/feature/home/presentation/view/widget/subjects_header.dart';
import 'package:study_box/feature/home/presentation/view/widget/quick_stats_card.dart';
import 'package:study_box/feature/home/presentation/view/widget/study_streak_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/motivational_quote_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/recent_subjects_widget.dart';

class HomeViewBody extends StatelessWidget {
  final List<dynamic> courses;
  final Map<String, dynamic> userData;
  final VoidCallback? onNavigateToSubjects;

  const HomeViewBody({
    super.key,
    required this.courses,
    required this.userData,
    this.onNavigateToSubjects,
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
          SliverToBoxAdapter(child: heightBox(10)),
          SliverToBoxAdapter(child: heightBox(10)),
          BlocBuilder<SubjectCubit, SubjectState>(
            builder: (context, state) {
              if (state is SubjectsLoaded && state.subjects.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SubjectsHeader(
                        onViewAllPressed: onNavigateToSubjects,
                      ),
                      heightBox(5),
                      RecentSubjectsWidget(
                        maxSubjects: 2,
                        onViewAllPressed: onNavigateToSubjects,
                      ),
                    ],
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          SliverToBoxAdapter(child: heightBox(20)),
        ],
      ),
    );
  }
}
