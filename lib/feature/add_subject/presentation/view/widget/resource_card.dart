import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class ResourceCard extends StatelessWidget {
  final ResourceItem resource;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final bool showActions;
  final String? uploaderName;
  final String? planLabel;

  const ResourceCard({
    super.key,
    required this.resource,
    this.onRemove,
    this.onTap,
    this.onEdit,
    this.showActions = true,
    this.uploaderName,
    this.planLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.getNavigationBar(context),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: resource.color.withOpacity(0.3),
                width: 2.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: resource.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    resource.icon,
                    color: resource.color,
                    size: 20.sp,
                  ),
                ),
                widthBox(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.getTextPrimaryColor(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (resource.description.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          resource.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (uploaderName != null || planLabel != null) ...[
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            if (uploaderName != null) ...[
                              Icon(Icons.person, size: 12.sp, color: Colors.grey[600]),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  uploaderName!,
                                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[700]),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                            if (planLabel != null) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  planLabel!,
                                  style: TextStyle(fontSize: 10.sp, color: Colors.blue[700]),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                      if (resource.type != ResourceType.link) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: resource.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            _getTypeLabel(resource.type),
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: resource.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (showActions) ...[
                  if (onEdit != null)
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.blue[400],
                          size: 18.sp,
                        ),
                      ),
                    ),
                  if (onRemove != null)
                    GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red[400],
                          size: 18.sp,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTypeLabel(ResourceType type) {
    switch (type) {
      case ResourceType.book:
        return 'Book';
      case ResourceType.pdf:
        return 'PDF';
      case ResourceType.image:
        return 'Image';
      case ResourceType.link:
        return 'Link';
      case ResourceType.video:
        return 'Video';
      case ResourceType.audio:
        return 'Audio';
    }
  }
}
