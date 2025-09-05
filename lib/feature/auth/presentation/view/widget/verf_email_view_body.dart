import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
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
        children: [
          heightBox(50),
          Center(
            child: Text(
              'تأكيد البريد الالكتروني',
              style: Styles.font18MediumPrimaryBold(context),
            ),
          ),
          heightBox(20),
          Image.asset(
            Assets.imagesPngVerfEmailImage,
            height: 250.h,
            width: 250.w,
          ),
          heightBox(20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تم ارسال رمز التحقق الى بريدك الالكتروني',
              style: Styles.font14MediumPrimaryBold(context),
            ),
          ),
          heightBox(10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'من فضلك ادخل الرمز المكون من 6 ارقام',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          heightBox(15),
          const CustomTextField(
            hintText: 'رمز التحقق',
            suffixIcon: IconlyLight.shield_done,
            keyboardType: TextInputType.number,
          ),
          heightBox(20),
          CustomButton(
            text: 'التحقق',
            onPressed: () {},
          ),
          heightBox(20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'اعادة ارسال الرمز',
                style: Styles.font13MediumGreyBold(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
