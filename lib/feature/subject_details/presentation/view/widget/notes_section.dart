import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/note_card.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({
    super.key,
    required this.notes,
    required this.isExpanded,
    required this.onToggle,
  });

  final List<String> notes;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: const Color(0xFF6366F1),
                      size: 24.sp,
                    ),
                  ),
                  widthBox(12),
                  Text(
                    'Notes',
                    style: Styles.font18PrimaryColorTextBold(context),
                  ),
                  widthBox(10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${notes.length}',
                      style: TextStyle(
                        color: const Color(0xFF6366F1),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF9CA3AF),
                    size: 28.sp,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                children: notes.map((note) => NoteCard(note: note)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
