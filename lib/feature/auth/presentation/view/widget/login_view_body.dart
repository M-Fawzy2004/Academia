import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/auth/presentation/view/widget/auth_redirect_text.dart';
import 'package:study_box/feature/auth/presentation/view/widget/login_form_wrapper.dart';
import 'package:study_box/feature/auth/presentation/view/widget/login_with_social.dart';
import 'package:study_box/feature/auth/presentation/view/widget/or_divider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(80),
          Icon(
            Icons.school,
            size: 80.sp,
            color: AppColors.darkLightGrey,
          ),
          heightBox(5),
          Text(
            "StudyBox",
            style: TextStyle(
              color: AppColors.darkLightGrey,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          heightBox(50),
          const LoginFormWrapper(),
          heightBox(15),
          const OrDivider(),
          heightBox(20),
          const LoginWithSocial(),
          heightBox(30),
          AuthRedirectText(
            onTap: () {
              context.push(AppRouter.registerView);
            },
            title: context.tr.login_not_have_an_account,
            buttonTitle: "  ${context.tr.login_register}",
          ),
          heightBox(15),
        ],
      ),
    );
  }
}

