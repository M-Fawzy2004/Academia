import 'package:equatable/equatable.dart';

enum ReminderType { subject, task, custom }

enum ReminderPriority { high, medium, low }

class ReminderEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final ReminderType type;
  final bool isCompleted;
  final String? subjectId;
  final int? notificationId;
  final ReminderPriority priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReminderEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.type,
    required this.isCompleted,
    this.subjectId,
    this.notificationId,
    this.priority = ReminderPriority.medium,
    required this.createdAt,
    required this.updatedAt,
  });

  ReminderEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? date,
    String? time,
    ReminderType? type,
    bool? isCompleted,
    String? subjectId,
    int? notificationId,
    ReminderPriority? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      subjectId: subjectId ?? this.subjectId,
      notificationId: notificationId ?? this.notificationId,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        date,
        time,
        type,
        isCompleted,
        subjectId,
        notificationId,
        priority,
        createdAt,
        updatedAt,
      ];
}