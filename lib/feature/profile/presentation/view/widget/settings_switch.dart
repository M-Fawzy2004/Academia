import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:load_switch/load_switch.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';

class SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(icon),
          widthBox(15),
          Text(
            title,
            style: Styles.font16PrimaryColorTextBold(context),
          ),
          const Spacer(),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRTL ? 3.14159 : 0),
            child: LoadSwitch(
              value: value,
              future: () => getFuture(),
              onChange: onChanged,
              onTap: (val) {},
              width: 45.w,
              height: 25.h,
              style: SpinStyle.material,
              switchDecoration: (val, isFocus) => BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: val ? AppColors.primaryColor : Colors.grey.shade300,
                border: Border.all(
                  color: val
                      ? AppColors.primaryColor.withOpacity(0.3)
                      : Colors.grey.shade400,
                  width: 1.w,
                ),
              ),
              thumbDecoration: (val, isFocus) => BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> getFuture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return !value;
  }
}
