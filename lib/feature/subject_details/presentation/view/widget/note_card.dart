import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/styles.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1).withOpacity(0.08),
            const Color(0xFF8B5CF6).withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(
            color: const Color(0xFF6366F1),
            width: 5.w,
          ),
        ),
      ),
      child: Text(
        note,
        style: Styles.font13GreyBold(context),
      ),
    );
  }
}
