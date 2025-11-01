import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';

class SubscriptionCard extends StatelessWidget {
  final VoidCallback onPressed;

  const SubscriptionCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          child: const Icon(
            Icons.subscriptions_outlined,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          context.tr.manage_subscriptions,
          style: Styles.font14PrimaryColorTextBold(context),
        ),
        subtitle: Text(
          context.tr.subscriptions_desc,
          style: Styles.font12GreyBold(context),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.getCardColor(context),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
