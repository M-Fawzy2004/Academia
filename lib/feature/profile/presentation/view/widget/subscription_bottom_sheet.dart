import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

class SubscriptionBottomSheet extends StatefulWidget {
  const SubscriptionBottomSheet({super.key});

  @override
  State<SubscriptionBottomSheet> createState() => SubscriptionBottomSheetState();
}

class SubscriptionBottomSheetState extends State<SubscriptionBottomSheet> {
  int selectedPlanIndex = 1;

  void onPlanSelected(int index) {
    setState(() {
      selectedPlanIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHandle(),
          SizedBox(height: 8.h),
          SubscriptionHeader(),
          SizedBox(height: 24.h),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SubscriptionPlanCard(
                    planName: 'Free',
                    price: '\$0',
                    period: 'Forever',
                    features: [
                      'Access to basic features',
                      'Limited study materials',
                      'Community support',
                    ],
                    icon: Icons.star_border_rounded,
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade600],
                    ),
                    isSelected: selectedPlanIndex == 0,
                    onTap: () => onPlanSelected(0),
                    index: 0,
                  ),
                  SizedBox(height: 16.h),
                  SubscriptionPlanCard(
                    planName: 'Premium',
                    price: '\$9.99',
                    period: 'Per Month',
                    features: [
                      'All basic features',
                      'Unlimited study materials',
                      'Priority support',
                      'Advanced analytics',
                    ],
                    icon: Icons.star_half_rounded,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                    ),
                    isSelected: selectedPlanIndex == 1,
                    onTap: () => onPlanSelected(1),
                    badge: 'Popular',
                    index: 1,
                  ),
                  SizedBox(height: 16.h),
                  SubscriptionPlanCard(
                    planName: 'Pro',
                    price: '\$19.99',
                    period: 'Per Month',
                    features: [
                      'Everything in Premium',
                      'AI-powered study assistant',
                      'Offline access',
                      'Custom study plans',
                      '1-on-1 mentoring sessions',
                    ],
                    icon: Icons.star_rounded,
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade400, Colors.purple.shade700],
                    ),
                    isSelected: selectedPlanIndex == 2,
                    onTap: () => onPlanSelected(2),
                    badge: 'Best Value',
                    index: 2,
                  ),
                  SizedBox(height: 24.h),
                  SubscribeButton(
                    selectedPlanIndex: selectedPlanIndex,
                    onPressed: () {
                      Navigator.pop(context);
                      // Add your subscription logic here
                    },
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.getBorderColor(context),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class SubscriptionHeader extends StatelessWidget {
  const SubscriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Text(
            'Choose Your Plan',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.getTextPrimaryColor(context),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Unlock premium features and boost your learning',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.getTextSecondaryColor(context),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final String period;
  final List<String> features;
  final IconData icon;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;
  final int index;

  const SubscriptionPlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.period,
    required this.features,
    required this.icon,
    required this.gradient,
    required this.isSelected,
    required this.onTap,
    required this.index,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.getCardColor(context),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected 
                  ? AppColors.primaryColor 
                  : AppColors.getBorderColor(context),
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PlanIconContainer(
                      icon: icon,
                      gradient: gradient,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.getTextPrimaryColor(context),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                price,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.h),
                                child: Text(
                                  period,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.getTextSecondaryColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PlanSelectionCheckmark(isSelected: isSelected),
                  ],
                ),
                SizedBox(height: 16.h),
                FeaturesList(features: features),
              ],
            ),
          ),
          if (badge != null)
            BadgeWidget(badge: badge!),
        ],
      ),
    );
  }
}

class PlanIconContainer extends StatelessWidget {
  final IconData icon;
  final Gradient gradient;

  const PlanIconContainer({
    super.key,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }
}

class PlanSelectionCheckmark extends StatelessWidget {
  final bool isSelected;

  const PlanSelectionCheckmark({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected 
            ? AppColors.primaryColor 
            : AppColors.getBorderColor(context),
          width: 2,
        ),
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
      ),
      child: isSelected
        ? Icon(
            Icons.check,
            color: Colors.white,
            size: 16.sp,
          )
        : null,
    );
  }
}

class FeaturesList extends StatelessWidget {
  final List<String> features;

  const FeaturesList({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features.map((feature) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 18.sp,
                color: AppColors.success,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.getTextSecondaryColor(context),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final String badge;

  const BadgeWidget({
    super.key,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10.h,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          gradient: AppColors.getPrimaryGradient(),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          badge,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SubscribeButton extends StatelessWidget {
  final int selectedPlanIndex;
  final VoidCallback onPressed;

  const SubscribeButton({
    super.key,
    required this.selectedPlanIndex,
    required this.onPressed,
  });

  String getButtonText() {
    if (selectedPlanIndex == 0) return 'Continue with Free';
    if (selectedPlanIndex == 1) return 'Subscribe to Premium';
    return 'Subscribe to Pro';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54.h,
      decoration: BoxDecoration(
        gradient: AppColors.getPrimaryGradient(),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              getButtonText(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}