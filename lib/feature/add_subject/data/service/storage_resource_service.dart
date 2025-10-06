import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageResourceService {
  StorageResourceService({
    required this.supabaseClient,
    this.resourcesTableName = 'resources',
    this.enableResourcesInsert = true,
  });

  final SupabaseClient supabaseClient;
  final String resourcesTableName;
  final bool enableResourcesInsert;

  static const String bucketName = 'study_resources';

  Future<String> uploadSubjectFile({
    required String subjectId,
    required String filePath,
    String? overrideFileName,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist at $filePath');
    }

    final String originalName = overrideFileName ?? p.basename(filePath);
    final String ext = p.extension(originalName).toLowerCase().replaceAll('.', '');
    final String safeBase = p.basenameWithoutExtension(originalName).replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
    final String uniqueName = '${DateTime.now().millisecondsSinceEpoch}_$safeBase.$ext';

    final String storagePath = '$subjectId/$uniqueName';
    final String mimeType = _guessMimeFromExtension(ext);

    try {
      await supabaseClient.storage.from(bucketName).upload(
        storagePath,
        file,
        fileOptions: FileOptions(
          contentType: mimeType,
          upsert: false,
        ),
      );
    } on SocketException {
      throw Exception('Network error');
    }

    final String publicUrl = supabaseClient.storage.from(bucketName).getPublicUrl(storagePath);
    return publicUrl;
  }

  Future<void> insertResourceRow({
    required String subjectId,
    required String type, // e.g. 'image' | 'pdf'
    required String title,
    required String url,
    int? fileSizeMB,
  }) async {
    if (!enableResourcesInsert) return;
    try {
      await supabaseClient.from(resourcesTableName).insert({
        'subject_id': subjectId,
        'type': type,
        'title': title,
        'url': url,
        if (fileSizeMB != null) 'file_size_mb': fileSizeMB,
      });
    } on SocketException {
      print('Network error inserting resource row');
      // Continue execution even if insert fails
      // The file was uploaded successfully
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST205') {
        // Table not in schema cache or doesn't exist: ignore and continue
        return;
      }
      rethrow;
    }
  }

  String _guessMimeFromExtension(String ext) {
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }
}


