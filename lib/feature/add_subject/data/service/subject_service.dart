import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectService {
  final SupabaseClient supabaseClient;

  SubjectService({required this.supabaseClient});

  /// Add subject to Supabase
  Future<void> addSubject(SubjectModel subject) async {
    try {
      await supabaseClient
          .from(AppConstant.tableSubjects)
          .insert(subject.toJson());
    } catch (e) {
      throw Exception('Failed to add subject: $e');
    }
  }

  /// Get subjects by year and semester
  Future<List<SubjectModel>> getSubjectsByYearAndSemester(
    int year,
    int semester,
  ) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('user_id', userId)
          .eq('year', year)
          .eq('semester', semester)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => SubjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get subjects: $e');
    }
  }

  /// Get all subjects for current user
  Future<List<SubjectModel>> getAllSubjects() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => SubjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all subjects: $e');
    }
  }

  /// Update subject in Supabase
  Future<void> updateSubject(SubjectModel subject) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient
          .from(AppConstant.tableSubjects)
          .update(subject.toJson())
          .eq('id', subject.id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to update subject: $e');
    }
  }

  /// Delete subject from Supabase
  Future<void> deleteSubject(String id) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient
          .from(AppConstant.tableSubjects)
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to delete subject: $e');
    }
  }

  /// Get subject by ID
  Future<SubjectModel> getSubjectById(String id) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select()
          .eq('id', id)
          .eq('user_id', userId)
          .single();

      return SubjectModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get subject: $e');
    }
  }

  /// Get current user's subscription tier
  Future<SubscriptionTier> getUserSubscriptionTier() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.profileTable)
          .select('subscription_tier')
          .eq('id', userId)
          .single();

      final tierString = response['subscription_tier'] as String?;
      return SubscriptionTier.values.firstWhere(
        (tier) => tier.name == tierString,
        orElse: () => SubscriptionTier.free,
      );
    } catch (e) {
      return SubscriptionTier.free;
    }
  }

  /// Count subjects for current user
  Future<int> getSubjectCount() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableSubjects)
          .select('id')
          .eq('user_id', userId)
          .count(CountOption.exact);

      return response.count;
    } catch (e) {
      throw Exception('Failed to count subjects: $e');
    }
  }
}
