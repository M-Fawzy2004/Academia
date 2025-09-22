import '../../domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.id,
    required super.name,
    required super.code,
    required super.year,
    required super.semester,
    required super.doctorName,
    required super.creditHours,
    required super.notes,
    required super.resources,
    required super.lectures,
    required super.color,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      year: json['year'] as int,
      semester: json['semester'] as int,
      doctorName: json['doctor_name'] as String,
      creditHours: json['credit_hours'] as int,
      notes: json['notes'] as String,
      resources: (json['resources'] as List<dynamic>?)
              ?.map(
                (e) => ResourceItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      lectures: (json['lectures'] as List<dynamic>?)
              ?.map(
                (e) => LectureScheduleModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      color: json['color'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'year': year,
      'semester': semester,
      'doctor_name': doctorName,
      'credit_hours': creditHours,
      'notes': notes,
      'resources':
          resources.map((e) => (e as ResourceItemModel).toJson()).toList(),
      'lectures':
          lectures.map((e) => (e as LectureScheduleModel).toJson()).toList(),
      'color': color,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SubjectModel.fromEntity(SubjectEntity entity) {
    return SubjectModel(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      year: entity.year,
      semester: entity.semester,
      doctorName: entity.doctorName,
      creditHours: entity.creditHours,
      notes: entity.notes,
      resources:
          entity.resources.map((e) => ResourceItemModel.fromEntity(e)).toList(),
      lectures: entity.lectures
          .map((e) => LectureScheduleModel.fromEntity(e))
          .toList(),
      color: entity.color,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

class ResourceItemModel extends ResourceItem {
  const ResourceItemModel({
    required super.id,
    required super.type,
    required super.title,
    required super.url,
    super.fileSizeMB,
    required super.createdAt,
  });

  factory ResourceItemModel.fromJson(Map<String, dynamic> json) {
    return ResourceItemModel(
      id: json['id'] as String,
      type: ResourceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ResourceType.image,
      ),
      title: json['title'] as String,
      url: json['url'] as String,
      fileSizeMB: json['file_size_mb'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'url': url,
      'file_size_mb': fileSizeMB,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ResourceItemModel.fromEntity(ResourceItem entity) {
    return ResourceItemModel(
      id: entity.id,
      type: entity.type,
      title: entity.title,
      url: entity.url,
      fileSizeMB: entity.fileSizeMB,
      createdAt: entity.createdAt,
    );
  }
}

class LectureScheduleModel extends LectureSchedule {
  const LectureScheduleModel({
    required super.id,
    required super.day,
    required super.startTime,
    required super.endTime,
    super.location,
  });

  factory LectureScheduleModel.fromJson(Map<String, dynamic> json) {
    return LectureScheduleModel(
      id: json['id'] as String,
      day: DayOfWeek.values.firstWhere(
        (e) => e.name == json['day'],
        orElse: () => DayOfWeek.saturday,
      ),
      startTime:
          TimeOfDayModel.fromJson(json['start_time'] as Map<String, dynamic>),
      endTime:
          TimeOfDayModel.fromJson(json['end_time'] as Map<String, dynamic>),
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day.name,
      'start_time': (startTime as TimeOfDayModel).toJson(),
      'end_time': (endTime as TimeOfDayModel).toJson(),
      'location': location,
    };
  }

  factory LectureScheduleModel.fromEntity(LectureSchedule entity) {
    return LectureScheduleModel(
      id: entity.id,
      day: entity.day,
      startTime: TimeOfDayModel.fromEntity(entity.startTime),
      endTime: TimeOfDayModel.fromEntity(entity.endTime),
      location: entity.location,
    );
  }
}

class TimeOfDayModel extends TimeOfDay {
  const TimeOfDayModel({required super.hour, required super.minute});

  factory TimeOfDayModel.fromJson(Map<String, dynamic> json) {
    return TimeOfDayModel(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  factory TimeOfDayModel.fromEntity(TimeOfDay entity) {
    return TimeOfDayModel(
      hour: entity.hour,
      minute: entity.minute,
    );
  }
}
