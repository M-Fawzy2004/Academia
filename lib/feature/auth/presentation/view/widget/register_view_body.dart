import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/auth/presentation/view/widget/auth_redirect_text.dart';
import 'package:study_box/feature/auth/presentation/view/widget/register_form_wrapper.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

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
          const RegisterFormWrapper(),
          heightBox(15),
          AuthRedirectText(
            onTap: () {
              context.push(AppRouter.loginView);
            },
            title: context.tr.register_have_an_account,
            buttonTitle: "  ${context.tr.login_button}",
          ),
          heightBox(15),
        ],
      ),
    );
  }
}
