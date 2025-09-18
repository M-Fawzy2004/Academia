import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';

class ResourcesEmptyStateWidget extends StatelessWidget {
  final bool isArabic;

  const ResourcesEmptyStateWidget({
    super.key,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ResourcesEmptyIconWidget(),
          heightBox(8),
          ResourcesEmptyTitleWidget(isArabic: isArabic),
          heightBox(4),
          ResourcesEmptyDescriptionWidget(isArabic: isArabic),
        ],
      ),
    );
  }
}

class ResourcesEmptyIconWidget extends StatelessWidget {
  const ResourcesEmptyIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.folder_open_outlined,
      size: 40.sp,
      color: Colors.grey.withOpacity(0.5),
    );
  }
}

class ResourcesEmptyTitleWidget extends StatelessWidget {
  final bool isArabic;

  const ResourcesEmptyTitleWidget({
    super.key,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isArabic ? 'لا توجد مصادر حتى الآن' : 'No resources yet',
      style: Styles.font13GreyBold(context).copyWith(
        color: Colors.grey.withOpacity(0.7),
      ),
    );
  }
}

class ResourcesEmptyDescriptionWidget extends StatelessWidget {
  final bool isArabic;

  const ResourcesEmptyDescriptionWidget({
    super.key,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isArabic
          ? 'اضغط على الأزرار أعلاه لإضافة المصادر'
          : 'Tap the buttons above to add resources',
      style: TextStyle(
        fontSize: 11.sp,
        color: Colors.grey.withOpacity(0.6),
      ),
      textAlign: TextAlign.center,
    );
  }
}
