import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/profile/presentation/view/theme_selector_view.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_divider.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_navigation.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_section_header.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_switch.dart';

class GeneralSettingsSection extends StatefulWidget {
  const GeneralSettingsSection({super.key});

  @override
  State<GeneralSettingsSection> createState() => _GeneralSettingsSectionState();
}

bool notificationsEnabled = true;
String selectedLanguage = 'English';
bool darkModeEnabled = false;

class _GeneralSettingsSectionState extends State<GeneralSettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(
          title: context.tr.general_settings,
          icon: IconlyLight.setting,
        ),
        SettingsCard(
          children: [
            SettingsSwitch(
              icon: IconlyLight.notification,
              title: context.tr.notfication,
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.color_lens_rounded,
              title: context.tr.appearance,
              subtitle: context.tr.choose_appearance,
              onTap: () {
                context.navigateWithSlideTransition(const ThemeSelectorView());
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.language_rounded,
              title: context.tr.language,
              subtitle: selectedLanguage,
              onTap: () {},
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.emoji_events_rounded,
              title: context.tr.achievements,
              subtitle: context.tr.check_achievements,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
