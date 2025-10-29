import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/core/theme/theme_manager.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/core/service/notification_service.dart';
import 'package:study_box/academia_ai_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late NotificationService notificationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize TimeZones
  tz.initializeTimeZones();

  // Use device's local timezone
  final String deviceTimeZone = DateTime.now().timeZoneName;
  final Duration deviceOffset = DateTime.now().timeZoneOffset;

  try {
    // Try to set exact timezone by name
    tz.setLocalLocation(tz.getLocation(deviceTimeZone));
  } catch (e) {
    // If timezone name not found, find by offset
    try {
      final location = tz.timeZoneDatabase.locations.values.firstWhere(
        (location) =>
            tz.TZDateTime.now(location).timeZoneOffset == deviceOffset,
      );
      tz.setLocalLocation(location);
    } catch (e) {
      // Last fallback: use UTC
      tz.setLocalLocation(tz.getLocation('UTC'));
      debugPrint('Using UTC timezone');
    }
  }

  // Initialize Local Notifications
  notificationService = NotificationService(
    notificationsPlugin: flutterLocalNotificationsPlugin,
  );

  await notificationService.initialize();
  await notificationService.requestPermissions();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstant.supabaseURL,
    anonKey: AppConstant.supabaseKey,
  );

  // Initialize dependencies
  await initDependencies();

  // Load saved theme
  await ThemeManager.instance.loadSavedTheme();

  runApp(
    const AcademiaAiApp(),
  );
}
