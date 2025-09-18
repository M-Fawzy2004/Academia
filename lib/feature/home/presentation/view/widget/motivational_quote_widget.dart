import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/home/data/model/quote.dart';
import 'package:study_box/feature/home/data/service/quotes_service.dart';
import 'dart:developer' as developer;
import 'dart:async';

class MotivationalQuoteWidget extends StatefulWidget {
  const MotivationalQuoteWidget({super.key});

  @override
  State<MotivationalQuoteWidget> createState() =>
      _MotivationalQuoteWidgetState();
}

class _MotivationalQuoteWidgetState extends State<MotivationalQuoteWidget> {
  Quote? currentQuote;
  bool isLoading = false;
  bool hasError = false;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadQuote();
    _setupAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  /// Setup automatic refresh every 6 hours
  void _setupAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(hours: 6), (timer) {
      developer.log('Auto-refreshing quote after 6 hours');
      _loadQuote();
    });
  }

  /// Load quote (will use cached if still valid)
  Future<void> _loadQuote() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      developer.log('Loading quote...');

      // This will automatically handle caching
      final quote = await TimedQuotesService.getDailyQuote();

      if (mounted) {
        setState(() {
          currentQuote = quote;
          isLoading = false;
          hasError = false;
        });
        developer.log('Quote loaded: ${currentQuote?.text}');
      }
    } catch (e) {
      developer.log('Error loading quote: $e');
      if (mounted) {
        setState(() {
          currentQuote = TimedQuotesService.getFallbackQuote();
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  /// Force refresh quote (ignore cache)
  // Future<void> _forceRefreshQuote() async {
  //   if (!mounted) return;

  //   setState(() {
  //     isLoading = true;
  //     hasError = false;
  //   });

  //   try {
  //     developer.log('Force refreshing quote...');

  //     final quote = await TimedQuotesService.forceRefreshQuote();

  //     if (mounted) {
  //       setState(() {
  //         currentQuote = quote;
  //         isLoading = false;
  //         hasError = false;
  //       });
  //       developer.log('Quote force refreshed: ${currentQuote?.text}');

  //       // Show snackbar to confirm refresh
  //       CustomSnackBar.showSuccess(
  //         context,
  //         LanguageHelper.isArabic(context)
  //             ? 'تم تحديث القولة بنجاح'
  //             : 'Quote refreshed!',
  //       );
  //     }
  //   } catch (e) {
  //     developer.log('Error force refreshing quote: $e');
  //     if (mounted) {
  //       setState(() {
  //         currentQuote = TimedQuotesService.getFallbackQuote();
  //         isLoading = false;
  //         hasError = true;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingWidget();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.getCardColor(context),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1.5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.format_quote,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                ),
              ),
              widthBox(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.daily_inspiration,
                      style: Styles.font14MediumBold(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'Refreshes every 6 hours',
                      style: Styles.font12MediumWhiteBold(context).copyWith(
                        color: AppColors.primaryColor.withOpacity(0.7),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Manual refresh button
              // GestureDetector(
              //   onTap: _forceRefreshQuote,
              //   child: Container(
              //     padding: EdgeInsets.all(6.w),
              //     decoration: BoxDecoration(
              //       color: AppColors.primaryColor.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(6.r),
              //     ),
              //     child: Icon(
              //       Icons.refresh,
              //       color: AppColors.primaryColor,
              //       size: 16.sp,
              //     ),
              //   ),
              // ),
            ],
          ),
          heightBox(12),
          if (currentQuote != null) ...[
            Text(
              '"${currentQuote!.text}"',
              style: Styles.font15MediumBold(context).copyWith(
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
            heightBox(8),
            Row(
              children: [
                Icon(
                  IconlyBold.profile,
                  size: 14.sp,
                  color: AppColors.primaryColor,
                ),
                widthBox(4),
                Expanded(
                  child: Text(
                    '— ${currentQuote!.author}',
                    style: Styles.font13GreyBold(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                if (currentQuote!.category != null) ...[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      currentQuote!.category!.toUpperCase(),
                      style: Styles.font12MediumWhiteBold(context).copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (hasError) ...[
              heightBox(4),
              Text(
                '(Using offline quote)',
                style: Styles.font12MediumWhiteBold(context).copyWith(
                  color: Colors.orange,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ] else
            Center(
              child: Column(
                children: [
                  Text(
                    LanguageHelper.isArabic(context)
                        ? 'لا يمكن تحميل القولة'
                        : 'Unable to load quote',
                    style: Styles.font13GreyBold(context),
                  ),
                  heightBox(8),
                  GestureDetector(
                    onTap: _loadQuote,
                    child: Text(
                      LanguageHelper.isArabic(context)
                          ? 'إعادة المحاولة'
                          : 'Tap to retry',
                      style: Styles.font13GreyBold(context).copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.format_quote,
            color: AppColors.primaryColor.withOpacity(0.5),
            size: 20.sp,
          ),
          widthBox(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                heightBox(8),
                Container(
                  height: 14.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
