import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/extension.dart';
import 'package:study_box/core/helper/language_manager.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/profile/presentation/view/theme_selector_view.dart';
import 'package:study_box/feature/profile/presentation/view/widget/language_selector_dialog.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_divider.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_navigation.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_section_header.dart';

class GeneralSettingsSection extends StatefulWidget {
  const GeneralSettingsSection({super.key});

  @override
  State<GeneralSettingsSection> createState() => _GeneralSettingsSectionState();
}

class _GeneralSettingsSectionState extends State<GeneralSettingsSection> {
  @override
  void initState() {
    super.initState();
    // Listen to language changes
    LanguageManager.instance.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    LanguageManager.instance.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _showLanguageSelector() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const LanguageSelectorDialog(),
    );
    if (result == true && mounted) {
      setState(() {});
    }
  }

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
            SettingsNavigation(
              icon: Icons.color_lens_outlined,
              title: context.tr.appearance,
              subtitle: context.tr.choose_appearance,
              onTap: () {
                context.navigateWithSlideTransition(const ThemeSelectorView());
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.language,
              title: context.tr.language,
              subtitle: LanguageManager.instance.currentLanguageName,
              onTap: _showLanguageSelector,
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: Icons.emoji_events_outlined,
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
