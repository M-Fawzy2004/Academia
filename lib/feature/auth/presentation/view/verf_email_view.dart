import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/auth/presentation/view/widget/verf_email_view_body.dart';

class VerfEmailView extends StatelessWidget {
  const VerfEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const VerfEmailViewBody(),
        ),
      ),
    );
  }
}
