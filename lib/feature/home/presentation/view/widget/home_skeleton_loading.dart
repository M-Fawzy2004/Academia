import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/home/presentation/view/widget/header_section.dart';
import 'package:study_box/feature/home/presentation/view/widget/subjects_header.dart';
import 'package:study_box/feature/home/presentation/view/widget/quick_stats_card.dart';
import 'package:study_box/feature/home/presentation/view/widget/study_streak_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/upcoming_tasks_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/motivational_quote_widget.dart';
import 'package:study_box/feature/home/presentation/view/widget/recent_subjects_widget.dart';

class HomeSkeletonLoading extends StatelessWidget {
  const HomeSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                SubjectsHeader(
                  onViewAllPressed: () {},
                ),
                heightBox(15),
                RecentSubjectsWidget(
                  maxSubjects: 2,
                  onViewAllPressed: () {},
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: heightBox(20)),
        ],
      ),
    );
  }
}