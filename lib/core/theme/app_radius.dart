import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRadius {
  static double small = 8.r;
  static double medium = 12.r;
  static double big = 16.r;
  static double large = 25.r;

  static BorderRadius get smallRadius => BorderRadius.circular(small);
  static BorderRadius get mediumRadius => BorderRadius.circular(medium);
  static BorderRadius get bigRadius => BorderRadius.circular(big);
  static BorderRadius get largeRadius => BorderRadius.circular(large);
}
