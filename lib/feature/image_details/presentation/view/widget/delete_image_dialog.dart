import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';

class DeleteImageDialog extends StatelessWidget {
  final String imageId;
  final ImageGalleryCubit cubit;

  const DeleteImageDialog({
    super.key,
    required this.imageId,
    required this.cubit,
  });

  static void show(BuildContext context, String imageId) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeleteImageDialog(
        imageId: imageId,
        cubit: context.read<ImageGalleryCubit>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 48,
              ),
            ),
            heightBox(20),
            // Title
            Text(
              'Delete Image',
              style: Styles.font20PrimaryColorTextBold(context),
            ),
            heightBox(12),
            // Message
            Text(
              'Are you sure you want to delete this image? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: Styles.font13GreyBold(context),
            ),
            heightBox(25),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Cancel',
                      style: Styles.font16PrimaryColorTextBold(context),
                    ),
                  ),
                ),
                widthBox(12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.deleteImage(imageId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Delete',
                      style: Styles.font16PrimaryColorTextBold(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
