import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/language_helper.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/styles.dart';
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
    
    // إذا كان في تعديل، نستخرج المؤلف من الوصف
    String author = '';
    String description = '';
    
    if (widget.initialResource != null) {
      final desc = widget.initialResource!.description;
      final isArabic = desc.startsWith('المؤلف:');
      final prefix = isArabic ? 'المؤلف:' : 'Author:';
      
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
      final isArabic = LanguageHelper.isArabic(context);
      final author = _authorController.text.trim();
      final description = _descriptionController.text.trim();
      
      String fullDescription = isArabic 
          ? 'المؤلف: $author'
          : 'Author: $author';
      
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
    final isArabic = LanguageHelper.isArabic(context);
    final isEditing = widget.initialResource != null;
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        isEditing
            ? (isArabic ? 'تعديل الكتاب' : 'Edit Book')
            : (isArabic ? 'إضافة كتاب جديد' : 'Add New Book'),
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
                labelText: isArabic ? 'اسم الكتاب *' : 'Book Title *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.book),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return isArabic ? 'يرجى إدخال اسم الكتاب' : 'Please enter book title';
                }
                return null;
              },
            ),
            
            heightBox(16),
            
            TextFormField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: isArabic ? 'اسم المؤلف *' : 'Author Name *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return isArabic ? 'يرجى إدخال اسم المؤلف' : 'Please enter author name';
                }
                return null;
              },
            ),
            
            heightBox(16),
            
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: isArabic ? 'وصف الكتاب (اختياري)' : 'Book Description (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              maxLength: 300,
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
            backgroundColor: Colors.orange,
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