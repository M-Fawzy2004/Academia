import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/ai/presentation/view/widget/ai_field_body.dart';
import 'package:study_box/feature/ai/presentation/view/widget/ai_view_header.dart';

class AiViewBody extends StatelessWidget {
  const AiViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        const AiViewHeader(),
        heightBox(10),
        const Expanded(child: AiFieldBody()),
      ],
    );
  }
}
