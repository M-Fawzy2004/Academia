import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/ai/presentation/view/widget/send_button.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key, required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'What do you want to ask?',
                hintStyle: Styles.font12GreyBold(context),
                filled: true,
                fillColor: AppColors.getCardColorTwo(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getTextPrimaryColor(context),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
            ),
          ),
          SizedBox(width: 8.w),
          SendButton(onPressed: onSend),
        ],
      ),
    );
  }
}
