import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class LinkDialog extends StatefulWidget {
  final Function(ResourceItem) onAdd;
  final ResourceItem? initialResource;
  /// If provided, forces the created/edited resource type (e.g., video or book)
  final ResourceType? forcedType;

  const LinkDialog({
    super.key,
    required this.onAdd,
    this.initialResource,
    this.forcedType,
  });

  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _urlController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialResource?.title ?? '',
    );
    _urlController = TextEditingController(
      text: widget.initialResource?.url ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialResource?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  bool _isVideoUrl(String url) {
    final u = url.toLowerCase();
    return u.contains('youtube.com/watch') ||
        u.contains('youtu.be/') ||
        u.contains('vimeo.com/') ||
        u.contains('dailymotion.com/') ||
        u.contains('video');
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text.trim();
      final isVideo = widget.forcedType != null
          ? widget.forcedType == ResourceType.video
          : _isVideoUrl(url);
      final bool isBook = widget.forcedType == ResourceType.book;
      final resource = ResourceItem(
        id: widget.initialResource?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? (isVideo
                ? 'Video Link'
                : (isBook ? 'Book Link' : 'Web Link'))
            : _descriptionController.text.trim(),
        type: isVideo
            ? ResourceType.video
            : (isBook ? ResourceType.book : ResourceType.link),
        url: url,
        icon: isVideo
            ? Icons.play_circle_outline_rounded
            : (isBook ? Icons.menu_book_rounded : Icons.link),
        color: isVideo
            ? Colors.purple
            : (isBook ? Colors.blue : AppColors.primaryColor),
      );

      widget.onAdd(resource);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialResource != null;
    final titleText = widget.forcedType == ResourceType.video
        ? (isEditing ? 'Edit Video Link' : 'Add Video Link')
        : widget.forcedType == ResourceType.book
            ? (isEditing ? 'Edit Book Link' : 'Add Book Link')
            : (isEditing ? 'Edit Link' : 'Add New Link');

    return Dialog(
      backgroundColor: AppColors.getBackgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      titleText,
                      style: Styles.font15MediumGreyBold(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),

            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        controller: _titleController,
                        hintText: 'Link Title',
                        prefixIcon: Icons.title,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter link title';
                          }
                          return null;
                        },
                      ),
                      heightBox(16),
                      CustomTextField(
                        controller: _urlController,
                        hintText: 'https://example.com',
                        prefixIcon: Icons.link,
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter URL';
                          }
                          if (!_isValidUrl(value.trim())) {
                            return 'Please enter a valid URL';
                          }
                          return null;
                        },
                      ),
                      heightBox(16),
                      CustomTextField(
                        controller: _descriptionController,
                        hintText: 'Description (Optional)',
                        prefixIcon: Icons.description,
                        maxLines: 2,
                        maxLength: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Divider
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),

            // Actions
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      isEditing ? 'Update' : 'Add',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
