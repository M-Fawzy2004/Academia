import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:study_box/feature/profile/presentation/view/widget/section_title.dart';
import 'package:study_box/feature/profile/presentation/view/widget/subscription_card.dart';

class EditAccountViewBody extends StatelessWidget {
  const EditAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(15),
          Row(
            children: [
              const IconBack(),
              const Spacer(),
              Text(
                context.tr.edit_profile,
                style: Styles.font20PrimaryColorTextBold(context),
              ),
              const Spacer(),
              SizedBox(width: 45.w, height: 45.w),
            ],
          ),
          heightBox(30),
          Text(
            context.tr.edit_profile_desc,
            style: Styles.font16PrimaryColorTextBold(context),
          ),
          heightBox(30),
          SectionTitle(
            title: context.tr.personal_info,
            icon: Icons.person,
          ),
          heightBox(10),
          const CustomTextField(
            hintText: 'Mohamed Fawzy',
            suffixIcon: IconlyLight.edit,
          ),
          heightBox(10),
          const CustomTextField(
            hintText: 'mofawzy.com7@gmail.com',
            suffixIcon: IconlyLight.edit,
          ),
          heightBox(30),
          SectionTitle(
            title: context.tr.academic_information,
            icon: Icons.school,
          ),
          heightBox(10),
          const CustomTextField(
            hintText: 'Faculty Computer and Information Systems',
            suffixIcon: IconlyLight.edit,
          ),
          heightBox(10),
          const CustomTextField(
            hintText: 'Tanta University',
            suffixIcon: IconlyLight.edit,
          ),
          heightBox(30),
          CustomButton(
            text: context.tr.save_changes,
            onPressed: () {},
          ),
          heightBox(30),
          SubscriptionCard(
            onPressed: () {},
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
