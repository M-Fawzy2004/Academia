import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/subject_details_view_body.dart';

class SubjectDetailsView extends StatelessWidget {
  const SubjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: const SubjectDetailsViewBody(),
        ),
      ),
    );
  }
}
