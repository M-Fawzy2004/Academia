import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.date,
    required super.time,
    required super.type,
    required super.isCompleted,
    super.subjectId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      type: ReminderType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ReminderType.custom,
      ),
      isCompleted: json['is_completed'] as bool,
      subjectId: json['subject_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title.replaceAll(RegExp('[\u0000]'), ''),
      'description': description.replaceAll(RegExp('[\u0000]'), ''),
      'date': date.toIso8601String(),
      'time': time,
      'type': type.name,
      'is_completed': isCompleted,
      'subject_id': subjectId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ReminderModel.fromEntity(ReminderEntity entity) {
    return ReminderModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      date: entity.date,
      time: entity.time,
      type: entity.type,
      isCompleted: entity.isCompleted,
      subjectId: entity.subjectId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
