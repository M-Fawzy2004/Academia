import 'dart:io';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/reminder_model.dart';
import '../../../../core/service/notification_service.dart';

class ReminderService {
  final SupabaseClient supabaseClient;
  final NotificationService notificationService;

  ReminderService({
    required this.supabaseClient,
    required this.notificationService,
  });

  Future<String> addReminder(ReminderModel reminder) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final notificationId =
          await notificationService.scheduleReminder(reminder);

      final Map<String, dynamic> payload =
          Map<String, dynamic>.from(reminder.toJson());

      for (final key in ['title', 'description']) {
        final value = payload[key];
        if (value is String) {
          payload[key] = value.replaceAll(RegExp('[\u0000]'), '');
        }
      }

      payload.remove('id');
      payload['user_id'] = userId;
      payload['notification_id'] = notificationId;

      final inserted = await supabaseClient
          .from(AppConstant.tableReminders)
          .insert(payload)
          .select('id')
          .single();

      return inserted['id'] as String;
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to add reminder: $e');
    }
  }

  Future<List<ReminderModel>> getAllReminders() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableReminders)
          .select()
          .eq('user_id', userId)
          .order('date', ascending: true)
          .order('time', ascending: true);

      return (response as List)
          .map((json) => ReminderModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get reminders: $e');
    }
  }

  Future<List<ReminderModel>> getRemindersByType(String type) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableReminders)
          .select()
          .eq('user_id', userId)
          .eq('type', type)
          .order('date', ascending: true);

      return (response as List)
          .map((json) => ReminderModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get reminders by type: $e');
    }
  }

  Future<List<ReminderModel>> getRemindersBySubject(String subjectId) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final response = await supabaseClient
          .from(AppConstant.tableReminders)
          .select()
          .eq('user_id', userId)
          .eq('subject_id', subjectId)
          .order('date', ascending: true);

      return (response as List)
          .map((json) => ReminderModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to get subject reminders: $e');
    }
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      if (reminder.notificationId != null) {
        await notificationService.cancelNotification(reminder.notificationId!);
      }

      final newNotificationId =
          await notificationService.scheduleReminder(reminder);

      final payload = Map<String, dynamic>.from(reminder.toJson());

      for (final key in ['title', 'description']) {
        final value = payload[key];
        if (value is String) {
          payload[key] = value.replaceAll(RegExp('[\u0000]'), '');
        }
      }

      payload['notification_id'] = newNotificationId;

      await supabaseClient
          .from(AppConstant.tableReminders)
          .update(payload)
          .eq('id', reminder.id)
          .eq('user_id', userId);
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to update reminder: $e');
    }
  }

  Future<void> deleteReminder(String id) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final reminder = await supabaseClient
          .from(AppConstant.tableReminders)
          .select()
          .eq('id', id)
          .eq('user_id', userId)
          .single();

      final notificationId = reminder['notification_id'] as int?;
      if (notificationId != null) {
        await notificationService.cancelNotification(notificationId);
      }

      await supabaseClient
          .from(AppConstant.tableReminders)
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to delete reminder: $e');
    }
  }

  Future<void> toggleReminderCompletion(String id, bool isCompleted) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await supabaseClient
          .from(AppConstant.tableReminders)
          .update({
            'is_completed': isCompleted,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id)
          .eq('user_id', userId);
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to toggle reminder: $e');
    }
  }

  Future<List<ReminderModel>> createRemindersFromSubjectLectures(
    String subjectId,
    String subjectName,
    List<dynamic> lectures,
  ) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final List<ReminderModel> createdReminders = [];

      for (final lecture in lectures) {
        final day = lecture['day'] as String;
        final startTime = lecture['start_time'] as Map<String, dynamic>;
        final location = lecture['location'] as String?;

        final nextLectureDate = _getNextDateForDay(day);
        final timeString =
            '${startTime['hour'].toString().padLeft(2, '0')}:${startTime['minute'].toString().padLeft(2, '0')}';

        final reminderModel = ReminderModel(
          id: '',
          userId: userId,
          title: subjectName,
          description: location != null ? 'Location: $location' : 'Lecture',
          date: nextLectureDate,
          time: timeString,
          type: ReminderType.subject,
          isCompleted: false,
          subjectId: subjectId,
          priority: ReminderPriority.medium,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          notificationId: null,
        );

        final notificationId =
            await notificationService.scheduleReminder(reminderModel);

        final reminderData = {
          'user_id': userId,
          'title': subjectName,
          'description': location != null ? 'Location: $location' : 'Lecture',
          'date': nextLectureDate.toIso8601String(),
          'time': timeString,
          'type': 'subject',
          'is_completed': false,
          'subject_id': subjectId,
          'notification_id': notificationId,
          'priority': 'medium',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        };

        final inserted = await supabaseClient
            .from(AppConstant.tableReminders)
            .insert(reminderData)
            .select()
            .single();

        createdReminders.add(ReminderModel.fromJson(inserted));
      }

      return createdReminders;
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception('Failed to create lecture reminders: $e');
    }
  }

  DateTime _getNextDateForDay(String dayName) {
    final days = {
      'saturday': DateTime.saturday,
      'sunday': DateTime.sunday,
      'monday': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'friday': DateTime.friday,
    };

    final targetDay = days[dayName.toLowerCase()] ?? DateTime.monday;
    final now = DateTime.now();
    final daysUntilTarget = (targetDay - now.weekday) % 7;

    if (daysUntilTarget == 0) {
      return now;
    }

    return now.add(Duration(days: daysUntilTarget));
  }
}
