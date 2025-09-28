import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_divider.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_item.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_navigation.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_section_header.dart';

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(
          title: 'About',
          icon: IconlyLight.info_circle,
        ),
        SettingsCard(
          children: [
            SettingsNavigation(
              icon: IconlyLight.paper,
              title: 'Terms & Conditions',
              subtitle: 'Learn more',
              onTap: () {
                print('Terms & Conditions pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.shield_done,
              title: 'Privacy Policy',
              subtitle: 'Learn more',
              onTap: () {
                print('Privacy Policy pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.call,
              title: 'Contact Support',
              subtitle: 'Email, Phone',
              onTap: () {
                print('Contact Support pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.help_outline_rounded,
              title: 'Help Center',
              subtitle: 'FAQ',
              onTap: () {
                print('Help Center pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.star,
              title: 'Rate App',
              subtitle: 'Rate us',
              onTap: () {
                print('Rate App pressed');
              },
            ),
            const SettingsDivider(),
            SettingsItem(
              icon: IconlyLight.info_circle,
              title: 'App Version',
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'v1.0.0',
                  style: Styles.font12MediumBold(context).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
