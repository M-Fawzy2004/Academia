import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/add_images_bottom_sheet.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/delete_image_dialog.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/image_details_header.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/main_image_view.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/thumbnails_grid.dart';

class LoadedGalleryContent extends StatelessWidget {
  final ImageGalleryLoaded state;

  const LoadedGalleryContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(10),
        ImageDetailsHeader(
          onAddImages: () => _showAddImagesDialog(context),
        ),
        heightBox(20),
        // Main Image Display
        Expanded(
          flex: 2,
          child: MainImageView(
            imageUrl: state.images[state.selectedIndex].url,
            imageName: state.images[state.selectedIndex].title,
            onDelete: () => _showDeleteDialog(
              context,
              state.images[state.selectedIndex].id,
            ),
          ),
        ),
        heightBox(40),
        // Thumbnails Grid
        Expanded(
          flex: 3,
          child: ThumbnailsGrid(
            images: state.images,
            selectedIndex: state.selectedIndex,
            onImageSelected: (index) {
              context.read<ImageGalleryCubit>().selectImage(index);
            },
          ),
        ),
      ],
    );
  }

  void _showAddImagesDialog(BuildContext context) {
    AddImagesBottomSheet.show(context);
  }

  void _showDeleteDialog(BuildContext context, String imageId) {
    DeleteImageDialog.show(context, imageId);
  }
}
