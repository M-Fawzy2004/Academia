import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_divider.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_navigation.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_section_header.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(
          title: context.tr.account,
          icon: IconlyLight.profile,
        ),
        SettingsCard(
          children: [
            SettingsNavigation(
              icon: IconlyLight.lock,
              title: context.tr.privacy_security_title,
              subtitle: context.tr.privacy_security_desc,
              onTap: () {
                print('Privacy & Security pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.document,
              title: context.tr.study_progress_title,
              subtitle: context.tr.study_progress_desc,
              onTap: () {
                print('Study Progress pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.delete,
              title: context.tr.delete_account_title,
              subtitle: context.tr.delete_account_desc,
              onTap: () {},
              trailing: Icon(
                IconlyLight.danger,
                color: Colors.red,
                size: 20.sp,
              ),
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.logout,
              title: context.tr.sign_out_title,
              subtitle: context.tr.sign_out_desc,
              onTap: () {
                context.read<AuthCubit>().signOut();
              },
              trailing: Icon(
                IconlyLight.logout,
                color: Colors.red,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
