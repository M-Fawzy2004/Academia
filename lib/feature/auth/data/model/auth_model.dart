import 'package:supabase_flutter/supabase_flutter.dart';

class AuthModel {
  final String? id;
  final String? email;
  final String? name;
  final String? profileImage;
  final String? university;
  final String? college;
  final bool emailVerified;
  final DateTime? createdAt;

  const AuthModel({
    this.id,
    this.email,
    this.name,
    this.profileImage,
    this.university,
    this.college,
    this.emailVerified = false,
    this.createdAt,
  });

  // Convert from Supabase User to AuthModel
  factory AuthModel.fromUser(User user, {Map<String, dynamic>? profile}) {
    return AuthModel(
      id: user.id,
      email: user.email,
      name: profile?['name'] ?? user.userMetadata?['name'],
      profileImage: profile?['profile_image'],
      university: profile?['university'],
      college: profile?['college'],
      emailVerified: user.emailConfirmedAt != null,
      // ignore: unnecessary_null_comparison
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  // Convert to JSON for database operations
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image': profileImage,
      'university': university,
      'college': college,
      'email_verified': emailVerified,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Convert from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profile_image'],
      university: json['university'],
      college: json['college'],
      emailVerified: json['email_verified'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // Copy with new values
  AuthModel copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImage,
    String? university,
    String? college,
    bool? emailVerified,
    DateTime? createdAt,
  }) {
    return AuthModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      university: university ?? this.university,
      college: college ?? this.college,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
