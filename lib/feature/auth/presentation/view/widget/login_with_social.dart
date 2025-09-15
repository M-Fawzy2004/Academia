import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/helper/translate.dart';
import 'package:study_box/core/utils/assets.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/auth/presentation/view/widget/social_login_button.dart';

class LoginWithSocial extends StatelessWidget {
  const LoginWithSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButton(
          text: context.tr.login_with_google,
          assetPath: Assets.imagesIconGoogle,
          onTap: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        ),
        if (Platform.isIOS) ...[
          heightBox(15),
          SocialLoginButton(
            text: context.tr.login_with_apple,
            assetPath: Assets.imagesIconApple,
            onTap: () {
              context.read<AuthCubit>().signInWithApple();
            },
          ),
        ],
      ],
    );
  }
}
