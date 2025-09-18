import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class LinkDialog extends StatefulWidget {
  final Function(ResourceItem) onAdd;
  final ResourceItem? initialResource; 

  const LinkDialog({
    super.key,
    required this.onAdd,
    this.initialResource,
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final resource = ResourceItem(
        id: widget.initialResource?.id ?? 
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty 
            ? (LanguageHelper.isArabic(context) ? 'رابط ويب' : 'Web Link')
            : _descriptionController.text.trim(),
        type: ResourceType.link,
        url: _urlController.text.trim(),
        icon: Icons.link,
        color: AppColors.primaryColor,
      );
      
      widget.onAdd(resource);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageHelper.isArabic(context);
    final isEditing = widget.initialResource != null;
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        isEditing
            ? (isArabic ? 'تعديل الرابط' : 'Edit Link')
            : (isArabic ? 'إضافة رابط جديد' : 'Add New Link'),
        style: Styles.font15MediumGreyBold(context),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: isArabic ? 'عنوان الرابط *' : 'Link Title *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return isArabic ? 'يرجى إدخال عنوان الرابط' : 'Please enter link title';
                }
                return null;
              },
            ),
            
            heightBox(16),
            
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: isArabic ? 'الرابط *' : 'URL *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.link),
                hintText: 'https://example.com',
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return isArabic ? 'يرجى إدخال الرابط' : 'Please enter URL';
                }
                if (!_isValidUrl(value.trim())) {
                  return isArabic ? 'يرجى إدخال رابط صحيح' : 'Please enter a valid URL';
                }
                return null;
              },
            ),
            
            heightBox(16),
            
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: isArabic ? 'الوصف (اختياري)' : 'Description (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 2,
              maxLength: 200,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            isArabic ? 'إلغاء' : 'Cancel',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(
            isEditing
                ? (isArabic ? 'تحديث' : 'Update')
                : (isArabic ? 'إضافة' : 'Add'),
          ),
        ),
      ],
    );
  }
}