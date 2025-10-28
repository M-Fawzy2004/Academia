import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:study_box/feature/ai/presentation/view/widget/chatbot_header_section.dart';

class AiViewHeader extends StatelessWidget {
  const AiViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IconBack(),
        widthBox(20),
        const ChatbotHeaderSection(),
        const Spacer(),
        SizedBox(
          width: 45.w,
          height: 45.w,
        ),
      ],
    );
  }
}
