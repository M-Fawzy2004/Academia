import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';

class VerfEmailViewBody extends StatelessWidget {
  const VerfEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(50),
          Center(
            child: Text(
              context.tr.confirm_email,
              style: Styles.font18MediumPrimaryBold(context),
            ),
          ),
          heightBox(20),
          Center(
            child: Image.asset(
              Assets.imagesPngVerfEmailImage,
              height: 250.h,
              width: 250.w,
            ),
          ),
          heightBox(20),
          Text(
            context.tr.send_code_with_email,
            style: Styles.font14MediumPrimaryBold(context),
          ),
          heightBox(10),
          Text(
            context.tr.enter_code,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          heightBox(15),
          CustomTextField(
            hintText: context.tr.verf_code,
            suffixIcon: IconlyLight.shield_done,
            keyboardType: TextInputType.number,
          ),
          heightBox(20),
          CustomButton(
            text: context.tr.verf,
            onPressed: () {},
          ),
          heightBox(20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text(
                context.tr.resend_code,
                style: Styles.font13MediumGreyBold(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
