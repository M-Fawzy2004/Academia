import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/home/presentation/manager/connection/courses_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_skeleton_loading.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_view_body.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_error_widget.dart';

class HomeBlocConsumer extends StatelessWidget {
  const HomeBlocConsumer({super.key, this.onNavigateToSubjects});
  final VoidCallback? onNavigateToSubjects;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {
        if (state is CoursesError && !state.isNetworkError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: _buildStateWidget(state, context),
        );
      },
    );
  }

  Widget _buildStateWidget(CoursesState state, BuildContext context) {
    switch (state.runtimeType) {
      case const (CoursesInitial):
      case const (CoursesLoading):
        return const HomeSkeletonLoading(
          key: ValueKey('skeleton_loading'),
        );

      case const (CoursesLoaded):
        final loadedState = state as CoursesLoaded;
        return HomeViewBody(
          key: const ValueKey('home_loaded'),
          courses: loadedState.courses,
          userData: loadedState.userData,
          onNavigateToSubjects: onNavigateToSubjects,
        );

      case const (CoursesNoInternet):
        return CoursesNoInternetWidget(
          key: const ValueKey('no_internet'),
          onRetry: () => context.read<CoursesCubit>().retry(),
        );

      case const (CoursesError):
        final errorState = state as CoursesError;
        return HomeErrorWidget(
          key: const ValueKey('error'),
          message: errorState.message,
          isNetworkError: errorState.isNetworkError,
          onRetry: () => context.read<CoursesCubit>().retry(),
        );

      default:
        return const HomeSkeletonLoading(
          key: ValueKey('skeleton_default'),
        );
    }
  }
}
