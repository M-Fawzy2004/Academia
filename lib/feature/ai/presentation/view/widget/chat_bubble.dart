import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/feature/ai/data/model/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) _buildAvatar(),
          if (!message.isMe) SizedBox(width: 8.w),
          _buildMessageContainer(context),
          if (message.isMe) SizedBox(width: 8.w),
          if (message.isMe) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: message.isMe
          ? AppColors.primaryColor
          : AppColors.primaryColor.withOpacity(0.2),
      child: Icon(
        message.isMe ? Icons.person : Icons.smart_toy_outlined,
        size: 18.sp,
        color: message.isMe ? Colors.white : AppColors.primaryColor,
      ),
    );
  }

  Widget _buildMessageContainer(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: message.isMe
              ? AppColors.primaryColor
              : AppColors.getCardColorTwo(context),
          borderRadius: BorderRadius.circular(AppRadius.large).copyWith(
            topLeft: message.isMe ? null : Radius.circular(4.r),
            topRight: message.isMe ? Radius.circular(4.r) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14.sp,
                color: message.isMe
                    ? Colors.white
                    : AppColors.getTextPrimaryColor(context),
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _formatTime(message.time),
              style: TextStyle(
                fontSize: 10.sp,
                color: message.isMe
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
