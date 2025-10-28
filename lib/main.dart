import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/core/service/notification_service.dart';
import 'package:study_box/firebase_options.dart';
import 'package:study_box/study_box_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late NotificationService notificationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize TimeZones
  tz.initializeTimeZones();

  // Get device timezone automatically
  try {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  } catch (e) {
    // Fallback to UTC if device timezone fails
    tz.setLocalLocation(tz.getLocation('UTC'));
    debugPrint('Could not get device timezone, using UTC: $e');
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
    const StudyBoxApp(),
  );
}
