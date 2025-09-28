import 'package:flutter/material.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/profile/presentation/view/widget/about_setting_section.dart';
import 'package:study_box/feature/profile/presentation/view/widget/account_settings_section.dart';
import 'package:study_box/feature/profile/presentation/view/widget/general_settings_section.dart';
import 'package:study_box/feature/profile/presentation/view/widget/notification_settings_section.dart';
import 'package:study_box/feature/profile/presentation/view/widget/premium_upgrade_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/profile_header_sction.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          heightBox(10),
          // Profile Header Section
          const ProfileHeaderSction(),
          heightBox(20),
          // Premium Upgrade Card
          const PremiumUpgradeCard(),
          heightBox(25),
          // General Settings Section
          const GeneralSettingsSection(),
          heightBox(20),
          // Notification Settings Section
          const NotificationSettingsSection(),
          heightBox(20),
          // Account Settings Section
          const AccountSettingsSection(),
          heightBox(20),
          // About Settings Section
          const AboutSettingsSection(),
          heightBox(30),
        ],
      ),
    );
  }
}
