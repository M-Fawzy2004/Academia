import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';
import 'package:study_box/feature/image_details/presentation/view/widget/image_gallery_states_handler.dart';

class ImageDetailsViewBody extends StatelessWidget {
  const ImageDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageGalleryCubit, ImageGalleryState>(
      builder: (context, state) {
        return ImageGalleryStatesHandler(state: state);
      },
    );
  }
}