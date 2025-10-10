part of 'image_gallery_cubit.dart';

abstract class ImageGalleryState {}

class ImageGalleryInitial extends ImageGalleryState {}

class ImageGalleryLoading extends ImageGalleryState {}

class ImageGalleryLoaded extends ImageGalleryState {
  final List<ResourceItemModel> images;
  final int selectedIndex;

  ImageGalleryLoaded({
    required this.images,
    this.selectedIndex = 0,
  });

  ImageGalleryLoaded copyWith({
    List<ResourceItemModel>? images,
    int? selectedIndex,
  }) {
    return ImageGalleryLoaded(
      images: images ?? this.images,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class ImageGalleryError extends ImageGalleryState {
  final String message;
  ImageGalleryError(this.message);
}

class ImageGalleryUploading extends ImageGalleryState {
  final double progress;
  ImageGalleryUploading(this.progress);
}
