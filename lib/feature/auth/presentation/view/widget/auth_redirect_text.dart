import 'package:flutter/material.dart';
import 'package:study_box/core/theme/styles.dart';

class AuthRedirectText extends StatelessWidget {
  const AuthRedirectText({
    super.key,
    required this.title,
    required this.buttonTitle,
    this.onTap,
  });

  final String title;
  final String buttonTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Styles.font13MediumGreyBold(context),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            buttonTitle,
            style: Styles.font14MediumPrimaryBold(context),
          ),
        ),
      ],
    );
  }
}
