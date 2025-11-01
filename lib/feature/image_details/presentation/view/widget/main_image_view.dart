import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';

class MainImageView extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final VoidCallback? onDelete;

  const MainImageView({
    super.key,
    required this.imageUrl,
    required this.imageName,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade300,
                      Colors.purple.shade300,
                    ],
                  ),
                ),
                child: Center(
                  child: CustomLoadingWidget(
                    height: 70.h,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.shade300,
                      Colors.orange.shade300,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Image name overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.large),
                bottomRight: Radius.circular(AppRadius.large),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    imageName,
                    style: Styles.font13MediumBold(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(IconlyBold.delete),
                    color: Colors.red,
                    iconSize: 24.sp,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
