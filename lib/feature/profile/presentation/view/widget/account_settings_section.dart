import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
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
        const SettingsSectionHeader(
          title: 'Account',
          icon: IconlyLight.profile,
        ),
        SettingsCard(
          children: [
            SettingsNavigation(
              icon: IconlyLight.lock,
              title: 'Privacy & Security',
              subtitle: 'Password, 2FA',
              onTap: () {
                print('Privacy & Security pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.document,
              title: 'Study Progress',
              subtitle: '85% completed this month',
              onTap: () {
                print('Study Progress pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.download,
              title: 'Backup & Sync',
              subtitle: 'Last backup: 2 hours ago',
              onTap: () {
                print('Backup & Sync pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.delete,
              title: 'Delete Account',
              subtitle: 'Permanently delete your account',
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
              title: 'Sign Out',
              subtitle: 'Sign out of your account',
              onTap: () {},
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
