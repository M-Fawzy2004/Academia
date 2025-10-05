import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject/presentation/view/widget/custom_search_widget.dart';
import 'package:study_box/feature/subject/presentation/view/widget/subjects_bloc_builder.dart';

class SubjectViewBody extends StatefulWidget {
  const SubjectViewBody({super.key});

  @override
  State<SubjectViewBody> createState() => _SubjectViewBodyState();
}

class _SubjectViewBodyState extends State<SubjectViewBody> {
  String searchQuery = '';
  String? selectedGrade;
  String? selectedSemester;

  @override
  void initState() {
    super.initState();
    context.read<SubjectCubit>().getAllSubjects();
  }

  void onSearchChanged(String query, String? grade, String? semester) {
    setState(() {
      searchQuery = query.toLowerCase();
      selectedGrade = grade;
      selectedSemester = semester;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: AppColors.getNavigationBar(context),
      onRefresh: () async {
        context.read<SubjectCubit>().getAllSubjects();
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox(15),
                Text(
                  'Study Subjects',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextPrimaryColor(context),
                  ),
                ),
                heightBox(10),
                CustomSearchWidget(
                  showGradeFilter: true,
                  showSemesterFilter: true,
                  onSearchChanged: onSearchChanged,
                ),
                heightBox(10),
              ],
            ),
          ),
          SubjectsBlocBuilder(
            searchQuery: searchQuery,
            selectedGrade: selectedGrade,
            selectedSemester: selectedSemester,
          ),
          SliverToBoxAdapter(child: heightBox(35)),
        ],
      ),
    );
  }
}
