import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/app_providers.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/image_details_view_body.dart';

class ImageDetailsView extends StatelessWidget {
  final String subjectId;

  const ImageDetailsView({
    super.key,
    required this.subjectId,
  });

  @override
  Widget build(BuildContext context) {
    return AppProviders.imageDetailsView(
      subjectId: subjectId,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const ImageDetailsViewBody(),
          ),
        ),
      ),
    );
  }
}
