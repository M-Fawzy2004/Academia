import 'package:flutter/material.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/empty_images_view.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/error_state_view.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/gallery_loading_skeleton.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/loaded_gallery_content.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/uploading_state_view.dart';

class ImageGalleryStatesHandler extends StatelessWidget {
  final ImageGalleryState state;

  const ImageGalleryStatesHandler({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ImageGalleryLoading) {
      return const GalleryLoadingSkeleton();
    }

    if (state is ImageGalleryError) {
      final errorState = state as ImageGalleryError;
      if (errorState.message.contains('No images found')) {
        return const EmptyImagesView();
      }
      return ErrorStateView(message: errorState.message);
    }

    if (state is ImageGalleryUploading) {
      final uploadingState = state as ImageGalleryUploading;
      return UploadingStateView(progress: uploadingState.progress);
    }

    if (state is ImageGalleryLoaded) {
      return LoadedGalleryContent(state: state as ImageGalleryLoaded);
    }

    return const Center(child: Text('Unknown state'));
  }
}
