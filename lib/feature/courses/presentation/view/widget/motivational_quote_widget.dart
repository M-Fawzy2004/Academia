import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/courses/data/model/quote.dart';
import 'package:study_box/feature/courses/data/service/quotes_service.dart';

class MotivationalQuoteWidget extends StatefulWidget {
  const MotivationalQuoteWidget({super.key});

  @override
  State<MotivationalQuoteWidget> createState() =>
      _MotivationalQuoteWidgetState();
}

class _MotivationalQuoteWidgetState extends State<MotivationalQuoteWidget> {
  Quote? currentQuote;
  bool isLoading = false;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadDailyQuote();
  }

  Future<void> _loadDailyQuote() async {
    setState(() => isLoading = true);

    try {
      // Try to get educational quote
      final quote = await QuotesService.getQuoteByCategory('education');
      if (mounted) {
        setState(() {
          currentQuote = quote;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          currentQuote = QuotesService.getFallbackQuote();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingWidget();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
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
              Text(
                'Daily Inspiration',
                style: Styles.font14MediumBold(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
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
                Text(
                  '— ${currentQuote!.author}',
                  style: Styles.font13GreyBold(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                if (currentQuote!.category != null) ...[
                  const Spacer(),
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
          ] else
            Center(
              child: Text(
                'Unable to load quote',
                style: Styles.font13GreyBold(context),
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
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: const CustomLoadingWidget(),
          ),
        ],
      ),
    );
  }
}
