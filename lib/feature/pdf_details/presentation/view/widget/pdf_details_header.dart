import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/icon_back.dart';

class PdfDetailsHeader extends StatelessWidget {
  const PdfDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IconBack(),
        const Spacer(),
        Text(
          'PDF Details',
          style: Styles.font20PrimaryColorTextBold(context),
        ),    
        const Spacer(),
        SizedBox(width: 45.w, height: 45.w),
      ],
    );
  }
}
