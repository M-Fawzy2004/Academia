import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/add_subject_bloc_consumer.dart';

class AddSubjectView extends StatelessWidget {
  const AddSubjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: const AddSubjectBlocConsumer(),
        ),
      ),
    );
  }
}
