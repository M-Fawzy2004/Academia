import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_box/core/const/app_constant.dart';

class SubjectHeaderColumn extends StatelessWidget {
  const SubjectHeaderColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(5),
        Align(
          alignment: LanguageHelper.isArabic(context)
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: const IconBack(),
        ),
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.school,
            color: AppColors.white,
            size: 50.sp,
          ),
        ),
        heightBox(5),
        Text(
          context.tr.add_new_subject,
          style: Styles.font18MediumBold(context),
        ),
        Text(
          context.tr.header_subject_Desc,
          style: Styles.font13GreyBold(context),
        ),
        heightBox(6),
        _PlanBadge(),
      ],
    );
  }
}

class _PlanBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchPlan(),
      builder: (context, snapshot) {
        final plan = snapshot.data ?? 'free';
        final Color color = _colorForPlan(plan);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withOpacity(0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium, color: color, size: 14.sp),
              widthBox(6),
              Text(
                plan,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _fetchPlan() async {
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;
      if (user == null) return 'free';
      final List<dynamic> prof = await client
          .from(AppConstant.subscriptionTable)
          .select('subscription_tier')
          .eq('id', user.id);
      if (prof.isEmpty) return 'free';
      final tier = (prof.first['subscription_tier'] as String?)?.trim();
      return (tier == null || tier.isEmpty) ? 'free' : tier;
    } catch (_) {
      return 'free';
    }
  }

  Color _colorForPlan(String plan) {
    switch (plan.toLowerCase()) {
      case 'pro':
        return Colors.orange;
      case 'medium':
      case 'premium':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
