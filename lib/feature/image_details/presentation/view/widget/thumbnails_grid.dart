import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/thumbnail_item.dart';

class ThumbnailsGrid extends StatelessWidget {
  final List<ResourceItemModel> images;
  final int selectedIndex;
  final Function(int) onImageSelected;

  const ThumbnailsGrid({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5.w,
              height: 25.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.purple.shade600],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            widthBox(10),
            Text(
              'All Images (${images.length})',
              style: Styles.font20PrimaryColorTextBold(context),
            ),
          ],
        ),
        heightBox(25),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ThumbnailItem(
                imageUrl: images[index].url,
                imageName: images[index].title,
                index: index,
                isSelected: index == selectedIndex,
                onTap: () => onImageSelected(index),
              );
            },
          ),
        ),
      ],
    );
  }
}