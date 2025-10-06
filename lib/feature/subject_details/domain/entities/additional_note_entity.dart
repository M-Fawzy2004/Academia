import 'package:equatable/equatable.dart';

class AdditionalNote extends Equatable {
  final String id;
  final String subjectId;
  final String userId;
  final String title;
  final String details;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdditionalNote({
    required this.id,
    required this.subjectId,
    required this.userId,
    required this.title,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  AdditionalNote copyWith({
    String? id,
    String? subjectId,
    String? userId,
    String? title,
    String? details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdditionalNote(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        subjectId,
        userId,
        title,
        details,
        createdAt,
        updatedAt,
      ];
}
