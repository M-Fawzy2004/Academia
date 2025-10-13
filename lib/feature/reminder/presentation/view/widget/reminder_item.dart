import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_config.dart';
import 'package:study_box/feature/reminder/presentation/view/widget/reminder_type_badge.dart';

class ReminderItem extends StatefulWidget {
  final ReminderItemData data;

  const ReminderItem({
    super.key,
    required this.data,
  });

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.data.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getCardColorTwo(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCompleted = !isCompleted;
                    });
                  },
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCompleted
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: isCompleted
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                widthBox(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.data.title,
                              style: Styles.font16PrimaryColorTextBold(context)
                                  .copyWith(
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color:
                                    isCompleted ? Colors.grey.shade600 : null,
                              ),
                            ),
                          ),
                          ReminderTypeBadge(type: widget.data.type),
                        ],
                      ),
                      heightBox(5),
                      Text(
                        widget.data.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          decoration:
                              isCompleted ? TextDecoration.lineThrough : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            IconlyLight.time_circle,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.data.time,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
