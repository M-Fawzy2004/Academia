import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/add_images_bottom_sheet.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/image_details_header.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/image_gallery_states_handler.dart';

class ImageDetailsViewBody extends StatelessWidget {
  const ImageDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(10),
        // Header
        ImageDetailsHeader(
          onAddImages: () => AddImagesBottomSheet.show(context),
        ),
        heightBox(20),
        // Main Content
        Expanded(
          child: BlocBuilder<ImageGalleryCubit, ImageGalleryState>(
            builder: (context, state) {
              return ImageGalleryStatesHandler(state: state);
            },
          ),
        ),
      ],
    );
  }
}
