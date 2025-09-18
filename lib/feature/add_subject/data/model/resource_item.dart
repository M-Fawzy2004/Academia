import 'package:flutter/material.dart';

enum ResourceType { book, pdf, image, link, video, audio }

class ResourceItem {
  final String id;
  final String title;
  final String description;
  final ResourceType type;
  final String? filePath;
  final String? url;
  final IconData icon;
  final Color color;

  ResourceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.filePath,
    this.url,
    required this.icon,
    required this.color,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'filePath': filePath,
      'url': url,
      'icon': icon.codePoint,
      'color': color.value,
    };
  }

  // Create from JSON
  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    return ResourceItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: ResourceType.values
          .firstWhere((e) => e.toString().split('.').last == json['type']),
      filePath: json['filePath'],
      url: json['url'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
    );
  }

  // Copy with method for updating
  ResourceItem copyWith({
    String? id,
    String? title,
    String? description,
    ResourceType? type,
    String? filePath,
    String? url,
    IconData? icon,
    Color? color,
  }) {
    return ResourceItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      filePath: filePath ?? this.filePath,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
