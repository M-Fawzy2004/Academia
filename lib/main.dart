import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/core/service/notification_service.dart';
import 'package:study_box/study_box_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late NotificationService notificationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize TimeZones
  initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

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
    DevicePreview(
      enabled: true,
      builder: (context) => const StudyBoxApp(),
    ),
  );
}
