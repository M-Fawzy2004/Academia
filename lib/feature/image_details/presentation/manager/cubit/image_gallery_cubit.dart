import 'package:bloc/bloc.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/add_subject/data/service/storage_resource_service.dart';
import 'package:study_box/feature/image_details/data/service/image_gallery_service.dart';
part 'image_gallery_state.dart';

class ImageGalleryCubit extends Cubit<ImageGalleryState> {
  final ImageGalleryService imageGalleryService;
  final StorageResourceService storageService;
  final String subjectId;

  ImageGalleryCubit({
    required this.imageGalleryService,
    required this.storageService,
    required this.subjectId,
  }) : super(ImageGalleryInitial());

  Future<void> loadImages() async {
    emit(ImageGalleryLoading());
    try {
      final images = await imageGalleryService.getSubjectImages(subjectId);
      
      if (images.isEmpty) {
        emit(ImageGalleryError('No images found for this subject'));
      } else {
        emit(ImageGalleryLoaded(images: images, selectedIndex: 0));
      }
    } catch (e) {
      emit(ImageGalleryError(e.toString()));
    }
  }

  void selectImage(int index) {
    final currentState = state;
    if (currentState is ImageGalleryLoaded) {
      emit(currentState.copyWith(selectedIndex: index));
    }
  }

  Future<void> uploadImages(List<String> imagePaths) async {
    try {
      emit(ImageGalleryUploading(0.0));

      for (int i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];
        
        // Upload to storage
        final imageUrl = await storageService.uploadSubjectFile(
          subjectId: subjectId,
          filePath: imagePath,
        );

        // Get file name
        final fileName = imagePath.split('/').last;

        // Add to subject
        await imageGalleryService.addImageToSubject(
          subjectId: subjectId,
          imageUrl: imageUrl,
          imageName: fileName,
        );

        // Update progress
        emit(ImageGalleryUploading((i + 1) / imagePaths.length));
      }

      // Reload images
      await loadImages();
    } catch (e) {
      emit(ImageGalleryError('Failed to upload images: $e'));
    }
  }

  Future<void> deleteImage(String imageId) async {
    try {
      await imageGalleryService.deleteImageFromSubject(
        subjectId: subjectId,
        imageId: imageId,
      );
      
      // Reload images
      await loadImages();
    } catch (e) {
      emit(ImageGalleryError('Failed to delete image: $e'));
    }
  }

  ResourceItemModel? get selectedImage {
    final currentState = state;
    if (currentState is ImageGalleryLoaded) {
      if (currentState.images.isEmpty) return null;
      return currentState.images[currentState.selectedIndex];
    }
    return null;
  }
}