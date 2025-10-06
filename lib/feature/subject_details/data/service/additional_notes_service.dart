import 'package:study_box/feature/subject_details/data/model/additional_note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdditionalNotesService {
  final SupabaseClient supabaseClient;

  AdditionalNotesService({required this.supabaseClient});

  /// Add a note to a subject
  Future<void> addNote({
    required String subjectId,
    required String title,
    required String details,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient.from('additional_notes').insert({
        'subject_id': subjectId,
        'user_id': userId,
        'title': title,
        'details': details,
      });
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  /// Get all notes for a subject
  Future<List<AdditionalNoteModel>> getNotesBySubjectId(
    String subjectId,
  ) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from('additional_notes')
          .select()
          .eq('subject_id', subjectId)
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map(
            (json) =>
                AdditionalNoteModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get notes: $e');
    }
  }

  /// Update a note
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String details,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient
          .from('additional_notes')
          .update({
            'title': title,
            'details': details,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', noteId)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  /// Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient
          .from('additional_notes')
          .delete()
          .eq('id', noteId)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}
