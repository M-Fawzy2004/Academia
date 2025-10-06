// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class ImagePickerService {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<ResourceItem?> pickImage(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return ResourceItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: image.name,
          description:
              LanguageHelper.isArabic(context) ? 'صورة مضافة' : 'Added Image',
          type: ResourceType.image,
          filePath: image.path,
          icon: Icons.image,
          color: Colors.green,
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  static Future<ResourceItem?> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return ResourceItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: image.name,
          description: LanguageHelper.isArabic(context)
              ? 'صورة من الكاميرا'
              : 'Camera Image',
          type: ResourceType.image,
          filePath: image.path,
          icon: Icons.camera_alt,
          color: Colors.green,
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error taking picture: $e');
      return null;
    }
  }

  static Future<void> showImageSourceDialog(
    BuildContext context,
    Function(ResourceItem) onImagePicked,
  ) async {
    final isArabic = LanguageHelper.isArabic(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title:
                    Text(isArabic ? 'اختيار من المعرض' : 'Choose from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  // Allow multiple selection from gallery
                  final List<XFile> images = await _imagePicker.pickMultiImage(
                    maxWidth: 1920,
                    maxHeight: 1080,
                    imageQuality: 85,
                  );
                  for (final image in images) {
                    onImagePicked(
                      ResourceItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: image.name,
                        description: isArabic ? 'صورة مضافة' : 'Added Image',
                        type: ResourceType.image,
                        filePath: image.path,
                        icon: Icons.image,
                        color: Colors.green,
                      ),
                    );
                  }
                },
              ),
              // Camera option removed to restrict to gallery uploads only
            ],
          ),
        );
      },
    );
  }

  static bool isImageFile(String? filePath) {
    if (filePath == null) return false;
    final extension = filePath.toLowerCase();
    return extension.endsWith('.jpg') ||
        extension.endsWith('.jpeg') ||
        extension.endsWith('.png') ||
        extension.endsWith('.gif') ||
        extension.endsWith('.webp') ||
        extension.endsWith('.bmp');
  }
}
