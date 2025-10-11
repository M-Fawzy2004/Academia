import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/localization/translate.dart';
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
        SettingsSectionHeader(
          title: context.tr.about,
          icon: IconlyLight.info_circle,
        ),
        SettingsCard(
          children: [
            SettingsNavigation(
              icon: IconlyLight.paper,
              title: context.tr.term_and_conditions,
              subtitle: context.tr.learn_more,
              onTap: () {
                print('Terms & Conditions pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.shield_done,
              title: context.tr.privacy_policy,
              subtitle: context.tr.learn_more,
              onTap: () {
                print('Privacy Policy pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.call,
              title: context.tr.contact_us_title,
              subtitle: context.tr.contact_us_desc,
              onTap: () {
                print('Contact Support pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.help_outline_rounded,
              title: context.tr.help_center,
              subtitle: context.tr.learn_more,
              onTap: () {
                print('Help Center pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.star,
              title: context.tr.rate_app,
              subtitle: context.tr.learn_more,
              onTap: () {
                print('Rate App pressed');
              },
            ),
            const SettingsDivider(),
            SettingsItem(
              icon: IconlyLight.info_circle,
              title: context.tr.app_version,
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
