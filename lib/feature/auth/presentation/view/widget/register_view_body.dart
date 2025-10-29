import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/theme_manager.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:study_box/feature/auth/presentation/view/widget/auth_redirect_text.dart';
import 'package:study_box/feature/auth/presentation/view/widget/register_form_wrapper.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager.instance;
    final currentTheme = themeManager.getEffectiveTheme(context);

    String splashImage;
    if (currentTheme == AppThemeMode.light) {
      splashImage = Assets.imagesPngSplashView;
    } else {
      splashImage = Assets.imagesPngSplashViewDark;
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(20),
          const Align(
            alignment: Alignment.centerLeft,
            child: IconBack(),
          ),
          Image.asset(
            splashImage,
            height: 170.h,
            width: 300.w,
          ),
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
