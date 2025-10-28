import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/feature/ai/presentation/view/widget/ai_view_body.dart';

class AiView extends StatelessWidget {
  const AiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: const AiViewBody(),
        ),
      ),
    );
  }
}
