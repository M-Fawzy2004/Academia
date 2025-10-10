import 'dart:io';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';

class ImageGalleryService {
  final SupabaseClient supabaseClient;

  ImageGalleryService({required this.supabaseClient});

  /// Get all images for a specific subject
  Future<List<ResourceItemModel>> getSubjectImages(String subjectId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Get subject with all resources
      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('id', subjectId)
          .eq('user_id', userId)
          .single();

      final subject = SubjectModel.fromJson(response);

      // Filter only image resources
      final imageResources = subject.resources
          .where((resource) => resource.type == ResourceType.image)
          .cast<ResourceItemModel>()
          .toList();

      // Sort by creation date (newest first)
      imageResources.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return imageResources;
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get images: $e');
    }
  }

  /// Add new image to subject
  Future<void> addImageToSubject({
    required String subjectId,
    required String imageUrl,
    required String imageName,
    int? fileSizeMB,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Get current subject
      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('id', subjectId)
          .eq('user_id', userId)
          .single();

      final subject = SubjectModel.fromJson(response);

      // Create new resource item
      final newImage = ResourceItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: ResourceType.image,
        title: imageName,
        url: imageUrl,
        fileSizeMB: fileSizeMB,
        createdAt: DateTime.now(),
      );

      // Add to resources list
      final updatedResources = [...subject.resources, newImage];

      // Update subject
      final updatedSubject = SubjectModel(
        id: subject.id,
        name: subject.name,
        code: subject.code,
        year: subject.year,
        semester: subject.semester,
        doctorName: subject.doctorName,
        creditHours: subject.creditHours,
        notes: subject.notes,
        resources: updatedResources,
        lectures: subject.lectures,
        color: subject.color,
        createdAt: subject.createdAt,
        updatedAt: DateTime.now(),
        lastAccessedAt: subject.lastAccessedAt,
      );

      await supabaseClient
          .from(AppConstant.tableSubjects)
          .update(updatedSubject.toJson())
          .eq('id', subjectId)
          .eq('user_id', userId);
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to add image: $e');
    }
  }

  /// Delete image from subject
  Future<void> deleteImageFromSubject({
    required String subjectId,
    required String imageId,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Get current subject
      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('id', subjectId)
          .eq('user_id', userId)
          .single();

      final subject = SubjectModel.fromJson(response);

      // Remove image from resources
      final updatedResources = subject.resources
          .where((resource) => resource.id != imageId)
          .toList();

      // Update subject
      final updatedSubject = SubjectModel(
        id: subject.id,
        name: subject.name,
        code: subject.code,
        year: subject.year,
        semester: subject.semester,
        doctorName: subject.doctorName,
        creditHours: subject.creditHours,
        notes: subject.notes,
        resources: updatedResources,
        lectures: subject.lectures,
        color: subject.color,
        createdAt: subject.createdAt,
        updatedAt: DateTime.now(),
        lastAccessedAt: subject.lastAccessedAt,
      );

      await supabaseClient
          .from(AppConstant.tableSubjects)
          .update(updatedSubject.toJson())
          .eq('id', subjectId)
          .eq('user_id', userId);

      // Optional: Delete from storage as well
      // await _deleteFromStorage(imageUrl);
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}
