import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/subject_details/domain/entities/additional_note_entity.dart';
import 'package:study_box/feature/subject_details/presentation/manager/cubit/additional_notes_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/edit_note_dialog.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.subjectId,
  });

  final AdditionalNote note;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and actions
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: Styles.font18PrimaryColorTextBold(context),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    size: 20.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      showEditNoteDialog(context, subjectId, note);
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 20.sp,
                            color: const Color(0xFF6366F1),
                          ),
                          widthBox(8),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 20.sp,
                            color: Colors.red,
                          ),
                          widthBox(8),
                          const Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Text(
              note.details,
              style: Styles.font13GreyBold(context),
            ),
          ),

          // Timestamp
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                widthBox(4),
                Text(
                  _formatDate(note.updatedAt),
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdditionalNotesCubit>().deleteNote(
                    noteId: note.id,
                    subjectId: subjectId,
                  );
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}