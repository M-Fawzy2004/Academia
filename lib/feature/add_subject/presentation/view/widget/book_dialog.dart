import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_text_field.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class BookDialog extends StatefulWidget {
  final Function(ResourceItem) onAdd;
  final ResourceItem? initialResource;

  const BookDialog({
    super.key,
    required this.onAdd,
    this.initialResource,
  });

  @override
  State<BookDialog> createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    String author = '';
    String description = '';

    if (widget.initialResource != null) {
      final desc = widget.initialResource!.description;
      final prefix = 'Author:';

      if (desc.startsWith(prefix)) {
        final parts = desc.split('\n');
        author = parts[0].replaceAll(prefix, '').trim();
        if (parts.length > 1) {
          description = parts.sublist(1).join('\n');
        }
      }
    }

    _titleController = TextEditingController(
      text: widget.initialResource?.title ?? '',
    );
    _authorController = TextEditingController(text: author);
    _descriptionController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final author = _authorController.text.trim();
      final description = _descriptionController.text.trim();

      String fullDescription = 'Author: $author';

      if (description.isNotEmpty) {
        fullDescription += '\n$description';
      }

      final resource = ResourceItem(
        id: widget.initialResource?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: fullDescription,
        type: ResourceType.book,
        icon: Icons.book,
        color: Colors.orange,
      );

      widget.onAdd(resource);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialResource != null;

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
                      isEditing
                          ? context.tr.edit_book
                          : context.tr.add_new_book,
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
                        prefixIcon: Icons.book,
                        hintText: context.tr.book_title,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return context.tr.required_book_title;
                          }
                          return null;
                        },
                      ),
                      heightBox(16),
                      CustomTextField(
                        controller: _authorController,
                        hintText: context.tr.book_author,
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return context.tr.required_book_author;
                          }
                          return null;
                        },
                      ),
                      heightBox(16),
                      CustomTextField(
                        controller: _descriptionController,
                        hintText: context.tr.book_desc,
                        maxLines: 3,
                        maxLength: 300,
                        prefixIcon: Icons.description,
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
                      context.tr.cancel,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  widthBox(12),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      isEditing ? context.tr.update : context.tr.add,
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
