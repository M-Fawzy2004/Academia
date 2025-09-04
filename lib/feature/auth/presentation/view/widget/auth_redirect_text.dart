import 'package:flutter/material.dart';
import 'package:study_box/core/theme/styles.dart';

class AuthRedirectText extends StatelessWidget {
  const AuthRedirectText({
    super.key,
    required this.title,
    required this.buttonTitle,
  });

  final String title;
  final String buttonTitle;

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
          onTap: () {},
          child: Text(
            buttonTitle,
            style: Styles.font14MediumPrimaryBold(context),
          ),
        ),
      ],
    );
  }
}
