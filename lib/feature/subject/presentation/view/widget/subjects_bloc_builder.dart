import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject/presentation/view/widget/empty_subjects_widget.dart';
import 'package:study_box/feature/subject/presentation/view/widget/loading_subjects_widget.dart';
import 'package:study_box/feature/subject/presentation/view/widget/subjects_list_widget.dart';

class SubjectsBlocBuilder extends StatelessWidget {
  final String searchQuery;
  final String? selectedGrade;
  final String? selectedSemester;

  const SubjectsBlocBuilder({
    super.key,
    required this.searchQuery,
    this.selectedGrade,
    this.selectedSemester,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectCubit, SubjectState>(
      listener: (context, state) {
        if (state is SubjectError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is SubjectLoading) {
          return const SliverToBoxAdapter(
            child: LoadingSubjectsWidget(),
          );
        }

        if (state is SubjectsLoaded) {
          final filteredSubjects = filterSubjects(state.subjects);

          if (filteredSubjects.isEmpty) {
            return SliverToBoxAdapter(
              child: EmptySubjectsWidget(
                hasFilters: hasActiveFilters(),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SubjectsListWidget(subjects: filteredSubjects);
              },
              childCount: 1,
            ),
          );
        }

        return SliverToBoxAdapter(
          child: EmptySubjectsWidget(
            hasFilters: hasActiveFilters(),
          ),
        );
      },
    );
  }

  List<SubjectEntity> filterSubjects(List<SubjectEntity> subjects) {
    return subjects.where((subject) {
      final matchesSearch = searchQuery.isEmpty ||
          subject.name.toLowerCase().contains(searchQuery) ||
          subject.code.toLowerCase().contains(searchQuery) ||
          (subject.doctorName.toLowerCase().contains(searchQuery));

      final matchesGrade =
          selectedGrade == null || subject.year.toString() == selectedGrade;

      final matchesSemester = selectedSemester == null ||
          subject.semester.toString() == selectedSemester;

      return matchesSearch && matchesGrade && matchesSemester;
    }).toList();
  }

  bool hasActiveFilters() {
    return searchQuery.isNotEmpty ||
        selectedGrade != null ||
        selectedSemester != null;
  }
}
