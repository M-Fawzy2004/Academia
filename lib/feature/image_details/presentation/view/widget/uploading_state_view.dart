import 'package:flutter/material.dart';
import 'package:study_box/core/helper/custom_loading_widget.dart';
import 'package:study_box/core/helper/spacing.dart';

class UploadingStateView extends StatelessWidget {
  final double progress;

  const UploadingStateView({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomLoadingWidget(),
          heightBox(16),
          Text(
            'Uploading... ${(progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}