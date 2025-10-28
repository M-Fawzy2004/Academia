import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';

class ChatbotHeaderSection extends StatelessWidget {
  const ChatbotHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.getCardColorTwo(context),
          ),
          child: Image.asset(
            Assets.imagesPngChatbot,
            height: 25.h,
            width: 25.w,
          ),
        ),
        widthBox(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chatbot',
              style: Styles.font16PrimaryColorTextBold(context),
            ),
            Text(
              'Chat with our AI assistant',
              style: Styles.font13GreyBold(context),
            ),
          ],
        ),
      ],
    );
  }
}
