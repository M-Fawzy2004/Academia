import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header Shimmer
        const SliverToBoxAdapter(
          child: _HeaderShimmer(),
        ),

        // Study Streak Shimmer
        const SliverToBoxAdapter(
          child: _StudyStreakShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(15)),

        // Motivational Quote Shimmer
        const SliverToBoxAdapter(
          child: _MotivationalQuoteShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(20)),

        // Quick Stats Shimmer
        const SliverToBoxAdapter(
          child: _QuickStatsShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(20)),

        // Upcoming Tasks Shimmer
        const SliverToBoxAdapter(
          child: _UpcomingTasksShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(25)),

        // Materials Header Shimmer (changed from "My Courses")
        const SliverToBoxAdapter(
          child: _MaterialsHeaderShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(15)),

        // Add Courses Button Shimmer
        const SliverToBoxAdapter(
          child: _AddCoursesButtonShimmer(),
        ),

        SliverToBoxAdapter(child: heightBox(20)),

        // Courses List Shimmer
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: const _CourseCardShimmer(),
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

class _ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;

  const _ShimmerContainer({
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightTextSecondary,
      highlightColor: AppColors.darkBackgroundColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.getCardColor(context),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
      ),
    );
  }
}

class _HeaderShimmer extends StatelessWidget {
  const _HeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(14),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerContainer(width: 100.w, height: 16.h),
                  heightBox(5),
                  _ShimmerContainer(width: 150.w, height: 20.h),
                ],
              ),
            ),
            _ShimmerContainer(
              width: 24.w,
              height: 24.h,
              borderRadius: 12.r,
            ),
          ],
        ),
        heightBox(20),
      ],
    );
  }
}

class _StudyStreakShimmer extends StatelessWidget {
  const _StudyStreakShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.getNavigationBar(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _ShimmerContainer(width: 50.w, height: 50.h, borderRadius: 25.r),
          widthBox(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerContainer(width: 120.w, height: 18.h),
                heightBox(5),
                _ShimmerContainer(width: 80.w, height: 14.h),
              ],
            ),
          ),
          _ShimmerContainer(width: 60.w, height: 30.h),
        ],
      ),
    );
  }
}

class _MotivationalQuoteShimmer extends StatelessWidget {
  const _MotivationalQuoteShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.getNavigationBar(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerContainer(width: double.infinity, height: 16.h),
          heightBox(8),
          _ShimmerContainer(width: double.infinity, height: 16.h),
          heightBox(8),
          _ShimmerContainer(width: 200.w, height: 16.h),
          heightBox(12),
          _ShimmerContainer(width: 100.w, height: 14.h),
        ],
      ),
    );
  }
}

class _QuickStatsShimmer extends StatelessWidget {
  const _QuickStatsShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index < 2 ? 10.w : 0),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.getNavigationBar(context),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _ShimmerContainer(
                    width: 30.w, height: 30.h, borderRadius: 15.r),
                heightBox(8),
                _ShimmerContainer(width: 40.w, height: 20.h),
                heightBox(4),
                _ShimmerContainer(width: 60.w, height: 12.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _UpcomingTasksShimmer extends StatelessWidget {
  const _UpcomingTasksShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.getNavigationBar(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerContainer(width: 120.w, height: 18.h),
          heightBox(15),
          ...List.generate(2, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: index < 1 ? 12.h : 0),
              child: Row(
                children: [
                  _ShimmerContainer(
                      width: 12.w, height: 12.h, borderRadius: 6.r),
                  widthBox(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerContainer(width: double.infinity, height: 14.h),
                        heightBox(4),
                        _ShimmerContainer(width: 100.w, height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MaterialsHeaderShimmer extends StatelessWidget {
  const _MaterialsHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ShimmerContainer(width: 80.w, height: 20.h), // Materials text
        const Spacer(),
        Row(
          children: [
            _ShimmerContainer(
                width: 16.w, height: 16.h, borderRadius: 8.r), // Icon
            widthBox(4),
            _ShimmerContainer(width: 50.w, height: 13.h), // "View all" text
          ],
        ),
      ],
    );
  }
}

class _AddCoursesButtonShimmer extends StatelessWidget {
  const _AddCoursesButtonShimmer();

  @override
  Widget build(BuildContext context) {
    return _ShimmerContainer(
      width: double.infinity,
      height: 50.h,
      borderRadius: 12.r,
    );
  }
}

class _CourseCardShimmer extends StatelessWidget {
  const _CourseCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getNavigationBar(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ShimmerContainer(width: 50.w, height: 50.h, borderRadius: 12.r),
              widthBox(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerContainer(width: double.infinity, height: 18.h),
                    heightBox(8),
                    _ShimmerContainer(width: 120.w, height: 14.h),
                  ],
                ),
              ),
              _ShimmerContainer(width: 24.w, height: 24.h, borderRadius: 12.r),
            ],
          ),
          heightBox(15),
          _ShimmerContainer(
              width: double.infinity, height: 6.h, borderRadius: 3.r),
          heightBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerContainer(width: 60.w, height: 12.h),
              _ShimmerContainer(width: 40.w, height: 12.h),
            ],
          ),
        ],
      ),
    );
  }
}
