import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';

class AddImagesBottomSheet extends StatelessWidget {
  final BuildContext parentContext;

  const AddImagesBottomSheet({
    super.key,
    required this.parentContext,
  });

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => AddImagesBottomSheet(
        parentContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Add Images',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Options
            _buildOption(
              context,
              icon: Icons.photo_library_rounded,
              iconColor: Colors.blue,
              title: 'Choose from Gallery',
              subtitle: 'Select multiple images',
              onTap: () => _pickImages(context),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages(BuildContext context) async {
    Navigator.pop(context);

    // استخدم الـ parentContext اللي فيه الـ ImageGalleryCubit
    final cubit = parentContext.read<ImageGalleryCubit>();

    try {
      final imagePicker = ImagePicker();
      final images = await imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty && parentContext.mounted) {
        final paths = images.map((img) => img.path).toList();
        await cubit.uploadImages(paths);

        if (parentContext.mounted) {
          CustomSnackBar.showInfo(
            parentContext,
            '${images.length} Images uploaded successfully',
          );
        }
      }
    } catch (e) {
      if (parentContext.mounted) {
        CustomSnackBar.showInfo(
          parentContext,
          'No images selected or failed to upload',
        );
      }
    }
  }
}
