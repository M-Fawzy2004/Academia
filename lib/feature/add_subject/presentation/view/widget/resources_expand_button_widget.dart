import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/presentation/manager/resources_cubit/resources_cubit.dart';

class ResourcesExpandButtonWidget extends StatelessWidget {
  final bool isExpanded;

  const ResourcesExpandButtonWidget({
    super.key,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ResourcesCubit>().toggleExpansion(),
      child: AnimatedRotation(
        turns: isExpanded ? 0.5 : 0,
        duration: const Duration(milliseconds: 300),
        child: Icon(
          Icons.expand_more,
          color: AppColors.primaryColor,
          size: 24.sp,
        ),
      ),
    );
  }
}
