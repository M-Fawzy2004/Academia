import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/book_details/presentation/view/widget/custom_open_book.dart';

class BookItemCard extends StatelessWidget {
  const BookItemCard({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Book Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.book_outlined,
              color: const Color(0xFF6366F1),
              size: 27.sp,
            ),
          ),
          // width box
          widthBox(7),
          // book title
          Text(
            title,
            style: Styles.font16PrimaryColorTextBold(context),
          ),
          // Spacer
          const Spacer(),
          // CustomOpenBook
          CustomOpenBook(
            bookUrl: url,
            bookTitle: title,
          ),
        ],
      ),
    );
  }
}
