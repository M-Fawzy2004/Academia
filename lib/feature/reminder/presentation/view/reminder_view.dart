import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/app_providers.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_bloc_consumer.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders.reminderView(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const ReminderBlocConsumer(),
          ),
        ),
      ),
    );
  }
}
