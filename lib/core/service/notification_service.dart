import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  NotificationService({required this.notificationsPlugin});

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );

    await _createNotificationChannels();
  }

  Future<void> _createNotificationChannels() async {
    final androidPlugin = notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // High Priority Channel - مع صوت المنبه
      const highPriorityChannel = AndroidNotificationChannel(
        'reminder_high_priority',
        'High Priority Reminders',
        description: 'Channel for high priority reminders with alarm sound',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        ledColor: Color.fromARGB(255, 255, 0, 0),
        showBadge: true,
      );

      // Medium Priority Channel - بدون صوت
      const mediumPriorityChannel = AndroidNotificationChannel(
        'reminder_medium_priority',
        'Medium Priority Reminders',
        description: 'Channel for medium priority reminders without sound',
        importance: Importance.defaultImportance,
        playSound: false,
        enableVibration: true,
        showBadge: true,
      );

      // Low Priority Channel - بدون صوت وبدون اهتزاز
      const lowPriorityChannel = AndroidNotificationChannel(
        'reminder_low_priority',
        'Low Priority Reminders',
        description: 'Channel for low priority reminders without sound',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
        showBadge: true,
      );

      await androidPlugin.createNotificationChannel(highPriorityChannel);
      await androidPlugin.createNotificationChannel(mediumPriorityChannel);
      await androidPlugin.createNotificationChannel(lowPriorityChannel);
    }
  }

  Future<void> requestPermissions() async {
    final androidPlugin = notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();

    final iosPlugin = notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<int> scheduleReminder(ReminderEntity reminder) async {
    final notificationId = reminder.notificationId ?? _generateNotificationId();
    final scheduledDate = _combineDateTime(reminder.date, reminder.time);

    await notificationsPlugin.zonedSchedule(
      notificationId,
      reminder.title,
      reminder.description.isNotEmpty ? reminder.description : 'Reminder',
      tz.TZDateTime.from(scheduledDate, tz.local),
      _buildNotificationDetails(reminder.priority),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      
    );

    return notificationId;
  }

  Future<void> cancelNotification(int notificationId) async {
    await notificationsPlugin.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await notificationsPlugin.pendingNotificationRequests();
  }

  NotificationDetails _buildNotificationDetails(ReminderPriority priority) {
    final channelInfo = _getChannelInfo(priority);

    final androidDetails = AndroidNotificationDetails(
      channelInfo.channelId,
      channelInfo.channelName,
      channelDescription: channelInfo.channelDescription,
      importance: channelInfo.importance,
      priority: Priority.max,
      playSound: channelInfo.playSound,
      enableVibration: channelInfo.enableVibration,
      enableLights: channelInfo.enableLights,
      icon: '@mipmap/ic_launcher',
      color: channelInfo.color,
      ledColor: channelInfo.ledColor,
      ledOnMs: 1000,
      ledOffMs: 500,
      fullScreenIntent: priority == ReminderPriority.high,
      category: AndroidNotificationCategory.alarm,
      visibility: NotificationVisibility.public,
      ongoing: false,
      autoCancel: true,
      channelShowBadge: true,
      audioAttributesUsage: priority == ReminderPriority.high
          ? AudioAttributesUsage.alarm
          : AudioAttributesUsage.notification,
      additionalFlags: priority == ReminderPriority.high
          ? Int32List.fromList(<int>[4]) // FLAG_INSISTENT
          : null,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: priority == ReminderPriority.high,
      sound: priority == ReminderPriority.high ? 'default' : null,
      badgeNumber: 1,
      interruptionLevel: priority == ReminderPriority.high
          ? InterruptionLevel.timeSensitive
          : InterruptionLevel.passive,
    );

    return NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  _NotificationChannelInfo _getChannelInfo(ReminderPriority priority) {
    switch (priority) {
      case ReminderPriority.high:
        return _NotificationChannelInfo(
          channelId: 'reminder_high_priority',
          channelName: 'High Priority Reminders',
          channelDescription: 'Important reminders with alarm sound',
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          enableLights: true,
          color: const Color.fromARGB(255, 255, 0, 0),
          ledColor: const Color.fromARGB(255, 255, 0, 0),
        );
      case ReminderPriority.medium:
        return _NotificationChannelInfo(
          channelId: 'reminder_medium_priority',
          channelName: 'Medium Priority Reminders',
          channelDescription: 'Normal reminders without sound',
          importance: Importance.defaultImportance,
          playSound: false,
          enableVibration: true,
          enableLights: false,
          color: const Color.fromARGB(255, 255, 152, 0),
          ledColor: const Color.fromARGB(255, 255, 152, 0),
        );
      case ReminderPriority.low:
        return _NotificationChannelInfo(
          channelId: 'reminder_low_priority',
          channelName: 'Low Priority Reminders',
          channelDescription: 'Low priority reminders without sound',
          importance: Importance.low,
          playSound: false,
          enableVibration: false,
          enableLights: false,
          color: const Color.fromARGB(255, 76, 175, 80),
          ledColor: const Color.fromARGB(255, 76, 175, 80),
        );
    }
  }

  DateTime _combineDateTime(DateTime date, String time) {
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
  }

  int _generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  void onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.id}');
  }
}

class _NotificationChannelInfo {
  final String channelId;
  final String channelName;
  final String channelDescription;
  final Importance importance;
  final bool playSound;
  final bool enableVibration;
  final bool enableLights;
  final Color color;
  final Color ledColor;

  _NotificationChannelInfo({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
    required this.importance,
    required this.playSound,
    required this.enableVibration,
    required this.enableLights,
    required this.color,
    required this.ledColor,
  });
}