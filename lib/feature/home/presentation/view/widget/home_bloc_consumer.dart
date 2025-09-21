import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/home/presentation/manager/connection/courses_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_view_body.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_shimmer_loading.dart';
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
          duration: const Duration(milliseconds: 300),
          child: _buildStateWidget(state, context),
        );
      },
    );
  }

  Widget _buildStateWidget(CoursesState state, BuildContext context) {
    switch (state.runtimeType) {
      case const (CoursesInitial):
      case const (CoursesLoading):
        return const HomeShimmerLoading();

      case const (CoursesLoaded):
        final loadedState = state as CoursesLoaded;
        return HomeViewBody(
          courses: loadedState.courses,
          userData: loadedState.userData,
          onNavigateToSubjects: onNavigateToSubjects,
        );

      case const (CoursesNoInternet):
        return CoursesNoInternetWidget(
          onRetry: () => context.read<CoursesCubit>().retry(),
        );

      case const (CoursesError):
        final errorState = state as CoursesError;
        return HomeErrorWidget(
          message: errorState.message,
          isNetworkError: errorState.isNetworkError,
          onRetry: () => context.read<CoursesCubit>().retry(),
        );

      default:
        return const HomeShimmerLoading();
    }
  }
}
