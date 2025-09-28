import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/profile/presentation/view/widget/edit_account_button.dart';
import 'package:study_box/feature/profile/presentation/view/widget/profile_avatar_with_edit.dart';

class ProfileHeaderSction extends StatelessWidget {
  const ProfileHeaderSction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Avatar With Edit
        const ProfileAvatarWithEdit(),
        heightBox(15),
        // Name
        Text(
          'Mohamed Fawzy',
          style: Styles.font18PrimaryColorTextBold(context),
        ),
        heightBox(5),
        // College And University
        Text(
          'Faculty Computer and Information Systems, Tanta University',
          textAlign: TextAlign.center,
          style: Styles.font12MediumBold(context).copyWith(
            color: Colors.grey[600],
          ),
        ),
        heightBox(3),
        // Email Address
        Text(
          'mofawzy.com7@gmail.com',
          style: Styles.font12MediumBold(context).copyWith(
            color: Colors.grey[600],
          ),
        ),
        heightBox(15),
        // Edit Account
        const EditAccountButton(),
      ],
    );
  }
}
