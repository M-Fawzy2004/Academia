import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:study_box/core/const/app_constant.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/study_box_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstant.supabaseURL,
    anonKey: AppConstant.supabaseKey,
  );

  // Initialize dependencies
  await initDependencies();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const StudyBoxApp(),
    ),
  );
}
