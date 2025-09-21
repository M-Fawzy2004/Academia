import 'package:flutter/material.dart';

class SubjectModel {
  final String title;
  final String grade;
  final String semester;
  final List<String> resources;
  final Color color;
  final IconData icon;

  const SubjectModel({
    required this.title,
    required this.grade,
    required this.semester,
    required this.resources,
    required this.color,
    required this.icon,
  });
}
