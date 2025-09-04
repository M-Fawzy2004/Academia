import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/auth/presentation/view/widget/auth_redirect_text.dart';

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
          const SizedBox(height: 8),
          Text(
            "StudyBox",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.darkLightGrey,
                  fontWeight: FontWeight.bold,
                ),
          ),
          heightBox(50),
          const CustomTextField(
            hintText: 'Email',
            suffixIcon: IconlyLight.message,
          ),
          heightBox(15),
          const CustomTextField(
            hintText: 'Password',
            suffixIcon: IconlyLight.password,
          ),
          heightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password?',
                style: Styles.font14MediumPrimaryBold(context),
              ),
            ],
          ),
          heightBox(35),
          CustomButton(
            text: 'Login',
            onPressed: () {},
          ),
          heightBox(15),
          const AuthRedirectText(
            title: "Don't have an account? ",
            buttonTitle: " Register",
          ),
          heightBox(15),
        ],
      ),
    );
  }
}
