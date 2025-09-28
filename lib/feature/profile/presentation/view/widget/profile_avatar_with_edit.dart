import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/utils/assets.dart';

class ProfileAvatarWithEdit extends StatelessWidget {
  const ProfileAvatarWithEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 45.r,
          backgroundImage: const AssetImage(Assets.imagesPngMofawzy),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              IconlyLight.camera,
              size: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
