import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/book_details/presentation/view/book_link_viewer.dart';

class CustomOpenBook extends StatelessWidget {
  const CustomOpenBook({
    super.key,
    required this.bookUrl,
    required this.bookTitle,
  });

  final String bookUrl;
  final String bookTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(
          BookLinkViewer(
            bookUrl: bookUrl,
            bookTitle: bookTitle,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          context.tr.open,
          style: Styles.font14PrimaryColorTextBold(context),
        ),
      ),
    );
  }
}
