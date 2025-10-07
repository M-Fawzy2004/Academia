// ignore_for_file: use_build_context_synchronously
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';

class PdfPickerService {
  static Future<ResourceItem?> pickPdf(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final sizeInMB = (file.size / 1024 / 1024).toStringAsFixed(1);

        return ResourceItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: file.name,
          description: 'PDF File - $sizeInMB MB',
          type: ResourceType.pdf,
          filePath: file.path,
          icon: Icons.picture_as_pdf,
          color: Colors.red,
        );
      }
      return null;
    } catch (e) {
      // Handle error - could show snackbar or log error
      debugPrint('Error picking PDF: $e');
      return null;
    }
  }

  static String getFormattedFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(1)} GB';
    }
  }

  static bool isPdfFile(String? filePath) {
    if (filePath == null) return false;
    return filePath.toLowerCase().endsWith('.pdf');
  }
}
