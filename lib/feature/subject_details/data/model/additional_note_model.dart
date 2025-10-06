import 'package:study_box/feature/subject_details/domain/entities/additional_note_entity.dart';

class AdditionalNoteModel extends AdditionalNote {
  const AdditionalNoteModel({
    required super.id,
    required super.subjectId,
    required super.userId,
    required super.title,
    required super.details,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdditionalNoteModel.fromJson(Map<String, dynamic> json) {
    return AdditionalNoteModel(
      id: json['id'] as String,
      subjectId: json['subject_id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      details: json['details'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'user_id': userId,
      'title': title,
      'details': details,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory AdditionalNoteModel.fromEntity(AdditionalNote entity) {
    return AdditionalNoteModel(
      id: entity.id,
      subjectId: entity.subjectId,
      userId: entity.userId,
      title: entity.title,
      details: entity.details,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
