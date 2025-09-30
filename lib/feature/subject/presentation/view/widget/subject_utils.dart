import 'package:flutter/material.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';

class SubjectUtils {
  static IconData getSubjectIcon(String subjectName) {
    final name = subjectName.toLowerCase();

    if (name.contains('math') || name.contains('رياضيات')) {
      return Icons.calculate_rounded;
    } else if (name.contains('physics') || name.contains('فيزياء')) {
      return Icons.science_rounded;
    } else if (name.contains('chemistry') || name.contains('كيمياء')) {
      return Icons.biotech_rounded;
    } else if (name.contains('biology') || name.contains('أحياء')) {
      return Icons.eco_rounded;
    } else if (name.contains('history') || name.contains('تاريخ')) {
      return Icons.history_edu_rounded;
    } else if (name.contains('language') || name.contains('لغة')) {
      return Icons.translate_rounded;
    } else if (name.contains('computer') || name.contains('حاسب')) {
      return Icons.computer_rounded;
    } else if (name.contains('art') || name.contains('فن')) {
      return Icons.palette_rounded;
    }

    return Icons.book_rounded;
  }

  static Map<String, dynamic> getResourceInfo(ResourceType type) {
    switch (type) {
      case ResourceType.image:
        return {'icon': Icons.image_rounded, 'label': 'Images'};
      case ResourceType.pdf:
        return {'icon': Icons.picture_as_pdf_rounded, 'label': 'PDFs'};
      case ResourceType.youtubeLink:
        return {'icon': Icons.play_circle_outline_rounded, 'label': 'Videos'};
      case ResourceType.bookLink:
        return {'icon': Icons.menu_book_rounded, 'label': 'Books'};
      case ResourceType.record:
        return {'icon': Icons.mic_rounded, 'label': 'Records'};
    }
  }

  static Map<ResourceType, int> groupResourcesByType(
      List<ResourceItem> resources) {
    final resourcesByType = <ResourceType, int>{};
    for (var resource in resources) {
      resourcesByType[resource.type] =
          (resourcesByType[resource.type] ?? 0) + 1;
    }
    return resourcesByType;
  }
}
