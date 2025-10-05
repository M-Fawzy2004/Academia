import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String name;
  final String code;
  final int year;
  final int semester;
  final String doctorName;
  final int creditHours;
  final String notes;
  final List<ResourceItem> resources;
  final List<LectureSchedule> lectures;
  final int color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastAccessedAt;

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.year,
    required this.semester,
    required this.doctorName,
    required this.creditHours,
    required this.notes,
    required this.resources,
    required this.lectures,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    this.lastAccessedAt,
  });

  // copyWith method
  SubjectEntity copyWith({
    String? id,
    String? name,
    String? code,
    int? year,
    int? semester,
    String? doctorName,
    int? creditHours,
    String? notes,
    List<ResourceItem>? resources,
    List<LectureSchedule>? lectures,
    int? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastAccessedAt,
  }) {
    return SubjectEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      doctorName: doctorName ?? this.doctorName,
      creditHours: creditHours ?? this.creditHours,
      notes: notes ?? this.notes,
      resources: resources ?? this.resources,
      lectures: lectures ?? this.lectures,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        year,
        semester,
        doctorName,
        creditHours,
        notes,
        resources,
        lectures,
        color,
        createdAt,
        updatedAt,
        lastAccessedAt,
      ];
}

class ResourceItem extends Equatable {
  final String id;
  final ResourceType type;
  final String title;
  final String url;
  final int? fileSizeMB;
  final DateTime createdAt;

  const ResourceItem({
    required this.id,
    required this.type,
    required this.title,
    required this.url,
    this.fileSizeMB,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, title, url, fileSizeMB, createdAt];
}

class LectureSchedule extends Equatable {
  final String id;
  final DayOfWeek day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? location;

  const LectureSchedule({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.location,
  });

  @override
  List<Object?> get props => [id, day, startTime, endTime, location];
}

class TimeOfDay extends Equatable {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  @override
  List<Object?> get props => [hour, minute];
}

enum ResourceType {
  image,
  pdf,
  youtubeLink,
  bookLink,
  record,
}

enum DayOfWeek {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
}

enum SubscriptionTier {
  free,
  medium,
  pro,
}

class SubscriptionLimits {
  final int maxSubjects;
  final int maxImagesPerSubject;
  final int maxPdfsPerSubject;
  final int maxPdfSizeMB;
  final int maxLinksPerSubject;

  const SubscriptionLimits({
    required this.maxSubjects,
    required this.maxImagesPerSubject,
    required this.maxPdfsPerSubject,
    required this.maxPdfSizeMB,
    required this.maxLinksPerSubject,
  });

  static const Map<SubscriptionTier, SubscriptionLimits> limits = {
    SubscriptionTier.free: SubscriptionLimits(
      maxSubjects: 6,
      maxImagesPerSubject: 20,
      maxPdfsPerSubject: 5,
      maxPdfSizeMB: 15,
      maxLinksPerSubject: 20,
    ),
    SubscriptionTier.medium: SubscriptionLimits(
      maxSubjects: 20,
      maxImagesPerSubject: 40,
      maxPdfsPerSubject: 15,
      maxPdfSizeMB: 25,
      maxLinksPerSubject: 20,
    ),
    SubscriptionTier.pro: SubscriptionLimits(
      maxSubjects: 40,
      maxImagesPerSubject: 999999,
      maxPdfsPerSubject: 999999,
      maxPdfSizeMB: 999999,
      maxLinksPerSubject: 999999,
    ),
  };
}
