import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:study_box/study_box_app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const StudyBoxApp(),
    ),
  );
}
