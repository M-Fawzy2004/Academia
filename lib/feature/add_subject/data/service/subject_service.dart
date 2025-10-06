import 'dart:io';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectService {
  final SupabaseClient supabaseClient;

  SubjectService({required this.supabaseClient});

  /// Add subject to Supabase with profile management and return its ID
  Future<String> addSubject(SubjectModel subject) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // First, ensure user profile exists
      await _ensureUserProfileExists(userId);

      final Map<String, dynamic> payload = Map<String, dynamic>.from(subject.toJson());
      // Remove any accidental null-bytes in text fields to avoid 22P05
      for (final key in ['name', 'code', 'doctor_name', 'notes']) {
        final value = payload[key];
        if (value is String) {
          payload[key] = value.replaceAll(RegExp('[\u0000]'), '');
        }
      }
      // Let Postgres generate UUID, and attach current user id
      payload.remove('id');
      payload['user_id'] = userId;
      // Ensure color fits int4 (strip alpha just in case)
      if (payload['color'] is int) {
        payload['color'] = (payload['color'] as int) & 0x00FFFFFF;
      }

      final inserted = await supabaseClient
          .from(AppConstant.tableSubjects)
          .insert(payload)
          .select('id')
          .single();

      return inserted['id'] as String;
    } on SocketException {
      throw Exception('Network error');
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
    } on SocketException {
      throw Exception('Network error');
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
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get all subjects: $e');
    }
  }

  /// Update subject in Supabase
  Future<void> updateSubject(SubjectModel subject) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final payload = Map<String, dynamic>.from(subject.toJson());
      for (final key in ['name', 'code', 'doctor_name', 'notes']) {
        final value = payload[key];
        if (value is String) {
          payload[key] = value.replaceAll(RegExp('[\u0000]'), '');
        }
      }

      await supabaseClient
          .from(AppConstant.tableSubjects)
          .update(payload)
          .eq('id', subject.id)
          .eq('user_id', userId);
    } on SocketException {
      throw Exception('Network error');
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
    } on SocketException {
      throw Exception('Network error');
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
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get subject: $e');
    }
  }

  /// Get current user's subscription tier with profile creation
  Future<SubscriptionTier> getUserSubscriptionTier() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Ensure profile exists first
      await _ensureUserProfileExists(userId);

      final List<dynamic> rows = await supabaseClient
          .from(AppConstant.subscriptionTable)
          .select('id, subscription_tier')
          .eq('id', userId);

      final row = rows.isNotEmpty ? rows.first as Map<String, dynamic> : {};
      final tierString = row['subscription_tier'] as String?;
      
      if (tierString == null || tierString.isEmpty) {
        // Update with default tier
        await supabaseClient.from(AppConstant.subscriptionTable).update({
          'subscription_tier': SubscriptionTier.free.name,
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('id', userId);
        return SubscriptionTier.free;
      }

      return SubscriptionTier.values.firstWhere(
        (tier) => tier.name == tierString,
        orElse: () => SubscriptionTier.free,
      );
    } on SocketException {
      print('Network error getting subscription tier');
      return SubscriptionTier.free;
    } catch (e) {
      print('Error getting subscription tier: $e');
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
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to count subjects: $e');
    }
  }

  /// Ensure user profile exists in profiles table
  Future<void> _ensureUserProfileExists(String userId) async {
    try {
      // Check if profile exists
      final existingProfile = await supabaseClient
          .from(AppConstant.subscriptionTable)
          .select('id')
          .eq('id', userId)
          .maybeSingle();

      if (existingProfile == null) {
        // Create profile if doesn't exist
        final userMetadata = supabaseClient.auth.currentUser?.userMetadata ?? {};
        final email = supabaseClient.auth.currentUser?.email ?? '';
        
        await supabaseClient.from(AppConstant.subscriptionTable).insert({
          'id': userId,
          'email': email,
          'full_name': userMetadata['full_name'] ?? '',
          'avatar_url': userMetadata['avatar_url'],
          'subscription_tier': SubscriptionTier.free.name,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
        
        print('Profile created for user: $userId');
      }
    } on SocketException {
      print('Network error ensuring profile exists');
      // Continue execution even if profile creation fails
      // The app should still work for adding subjects
    } catch (e) {
      print('Error ensuring profile exists: $e');
      // Continue execution even if profile creation fails
      // The app should still work for adding subjects
    }
  }

  /// Create or update user profile explicitly
  Future<void> createUserProfile({
    required String fullName,
    String? avatarUrl,
    SubscriptionTier tier = SubscriptionTier.free,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');
      
      final email = supabaseClient.auth.currentUser?.email ?? '';

      await supabaseClient.from(AppConstant.subscriptionTable).upsert({
        'id': userId,
        'email': email,
        'full_name': fullName,
        'avatar_url': avatarUrl,
        'subscription_tier': tier.name,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to create/update profile: $e');
    }
  }

  /// Get user profile information
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _ensureUserProfileExists(userId);

      final response = await supabaseClient
          .from(AppConstant.subscriptionTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } on SocketException {
      print('Network error getting user profile');
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }
}