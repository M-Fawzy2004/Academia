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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Icon(icon),
          widthBox(15),
          Text(
            title,
            style: Styles.font16PrimaryColorTextBold(context),
          ),
          const Spacer(),
          LoadSwitch(
            value: value,
            future: () => getFuture(),
            onChange: onChanged,
            onTap: (val) {},
            width: 45,
            height: 25,
            style: SpinStyle.material,
            thumbSizeRatio: 0.8.sp,
            switchDecoration: (val, isFocus) => BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: val ? AppColors.primaryColor : Colors.grey.shade400,
            ),
            thumbDecoration: (val, isFocus) => const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
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
