import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_divider.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_navigation.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_section_header.dart';
import 'package:study_box/feature/profile/presentation/view/widget/settings_switch.dart';

class NotificationSettingsSection extends StatefulWidget {
  const NotificationSettingsSection({super.key});

  @override
  State<NotificationSettingsSection> createState() =>
      _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState
    extends State<NotificationSettingsSection> {
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(
          title: 'Notification Settings',
          icon: IconlyLight.notification,
        ),
        SettingsCard(
          children: [
            SettingsSwitch(
              icon: IconlyLight.volume_up,
              title: 'Sound',
              value: soundEnabled,
              onChanged: (value) {
                setState(() {
                  soundEnabled = value;
                });
              },
            ),
            const SettingsDivider(),
            SettingsSwitch(
              icon: Icons.vibration,
              title: 'Vibration',
              value: vibrationEnabled,
              onChanged: (value) {
                setState(() {
                  vibrationEnabled = value;
                });
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.time_circle,
              title: 'Study Reminders',
              subtitle: 'Daily at 8:00 PM',
              onTap: () {
                print('Study reminders pressed');
              },
            ),
            const SettingsDivider(),
            SettingsNavigation(
              icon: IconlyLight.calendar,
              title: 'Exam Alerts',
              subtitle: 'Enabled',
              onTap: () {
                print('Exam alerts pressed');
              },
            ),
          ],
        ),
      ],
    );
  }
}
