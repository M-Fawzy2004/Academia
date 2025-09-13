import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendTimerWidget extends StatelessWidget {
  final int remainingTime;
  final String Function(int) formatTime;

  const ResendTimerWidget({
    super.key,
    required this.remainingTime,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.timer,
              size: 18.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Retransmission available during: ${formatTime(remainingTime)}',
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
