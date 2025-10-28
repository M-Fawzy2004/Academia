import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/home/presentation/manager/connection/courses_cubit.dart';
import 'package:study_box/feature/home/presentation/view/widget/home_bloc_consumer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.onNavigateToSubjects});
  final VoidCallback? onNavigateToSubjects;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit()..init(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: HomeBlocConsumer(
              onNavigateToSubjects: onNavigateToSubjects,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'chatBotFAB',
          onPressed: () {
            context.push(AppRouter.aiView);
          },
          backgroundColor: AppColors.primaryColor,
          elevation: 4,
          icon: Image.asset(Assets.imagesPngChatbot, height: 25.h),
          label: Text(
            'Chat Bot',
            style: Styles.font14MediumBold(context).copyWith(
              color: AppColors.getTextPrimaryColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
