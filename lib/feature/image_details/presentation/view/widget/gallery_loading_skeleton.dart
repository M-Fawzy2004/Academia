import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/main_image_view.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/thumbnails_grid.dart';

class GalleryLoadingSkeleton extends StatelessWidget {
  const GalleryLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Create dummy data for skeleton
    final dummyImages = List.generate(
      3,
      (index) => ResourceItemModel(
        id: 'skeleton_$index',
        title: 'Loading Image $index',
        url: 'https://via.placeholder.com/400',
        createdAt: DateTime.now(),
        type: ResourceType.image,
      ),
    );

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Column(
        children: [
          heightBox(50),
          // Main Image Skeleton
          Expanded(
            flex: 2,
            child: MainImageView(
              imageUrl: dummyImages[0].url,
              imageName: dummyImages[0].title,
              onDelete: () {},
            ),
          ),
          heightBox(40),
          // Thumbnails Skeleton
          Expanded(
            flex: 3,
            child: ThumbnailsGrid(
              images: dummyImages,
              selectedIndex: 0,
              onImageSelected: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
