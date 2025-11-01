// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/styles.dart';
import 'package:study_box/core/widget/custom_button.dart';
import 'package:study_box/feature/add_subject/data/model/resource_item.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart'
    as domain;
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/add_subject_form.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/color_options_row.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/lecture_days_selector.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/resources_widget.dart';
import 'package:study_box/feature/add_subject/presentation/view/widget/subject_header_column.dart'; // استيراد الـ widget الجديد
import 'package:study_box/core/helper/custom_loading_widget.dart';

class AddSubjectViewBody extends StatefulWidget {
  const AddSubjectViewBody({super.key});

  @override
  State<AddSubjectViewBody> createState() => _AddSubjectViewBodyState();
}

class _AddSubjectViewBodyState extends State<AddSubjectViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();
  final TextEditingController _subjectDrNameController =
      TextEditingController();
  final TextEditingController _subjectCreditsController =
      TextEditingController();
  final TextEditingController _subjectNotesController = TextEditingController();

  String? selectedYear;
  String? selectedSemester;
  Color? selectedColor = Colors.red;
  Map<String, Map<String, String>> lectureSchedule = {};
  List<ResourceItem> subjectResources = [];

  @override
  void dispose() {
    _subjectNameController.dispose();
    _subjectCodeController.dispose();
    _subjectDrNameController.dispose();
    _subjectCreditsController.dispose();
    _subjectNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SubjectHeaderColumn(),
          heightBox(25),
          ColorOptionsRow(
            initialSelectedColor: selectedColor,
            onColorSelected: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
          heightBox(20),
          AddSubjectForm(
            formKey: _formKey,
            subjectNameController: _subjectNameController,
            subjectCodeController: _subjectCodeController,
            subjectDrNameController: _subjectDrNameController,
            subjectCreditsController: _subjectCreditsController,
            subjectNotesController: _subjectNotesController,
            selectedYear: selectedYear,
            selectedSemester: selectedSemester,
            onYearChanged: (year) => setState(() => selectedYear = year),
            onSemesterChanged: (sem) => setState(() => selectedSemester = sem),
          ),
          heightBox(10),
          LectureDaysSelector(
            onScheduleChanged: (schedule) {
              setState(() {
                lectureSchedule = schedule;
              });
            },
            initialSchedule: lectureSchedule,
          ),
          heightBox(10),
          ResourcesWidget(
            onResourcesChanged: (resources) {
              setState(() {
                subjectResources = resources;
              });
            },
            initialResources: subjectResources,
          ),
          heightBox(20),
          CustomButton(
            text: context.tr.add_new_subject,
            onPressed: _onSavePressed,
          ),
          heightBox(20),
        ],
      ),
    );
  }
}

extension on _AddSubjectViewBodyState {
  void _onSavePressed() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedYear == null || selectedSemester == null) {
      CustomSnackBar.showError(
        context,
        context.tr.required_year_and_semester,
      );
      return;
    }

    final parsedCredits = int.tryParse(_subjectCreditsController.text.trim());
    if (parsedCredits == null) {
      CustomSnackBar.showError(
        context,
        context.tr.feild_credit_hours,
      );
      return;
    }

    final domain.SubjectEntity subject = domain.SubjectEntity(
      // leave id empty; service will remove and Postgres generates UUID
      id: '',
      name: _subjectNameController.text.trim(),
      code: _subjectCodeController.text.trim(),
      year: _mapYearToInt(selectedYear!),
      semester: _mapSemesterToInt(selectedSemester!),
      doctorName: _subjectDrNameController.text.trim(),
      creditHours: parsedCredits,
      notes: _subjectNotesController.text.trim(),
      resources: _mapResourcesToDomain(subjectResources),
      lectures: _mapLectureScheduleToDomain(lectureSchedule),
      // store only RGB to fit Postgres int4 and avoid overflow
      color: ((selectedColor ?? Colors.red).value & 0x00FFFFFF),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SavingDialog(),
    );

    // Delay 2 seconds before attempting save
    () async {
      final cubit = context.read<SubjectCubit>();
      await Future.delayed(const Duration(seconds: 3));

      final completer = Completer<void>();
      final sub = cubit.stream.listen((state) {
        if (state is SubjectSuccess || state is SubjectError) {
          if (!completer.isCompleted) completer.complete();
          // Dismiss dialog
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
      });

      cubit.addSubject(subject);

      try {
        await completer.future.timeout(const Duration(minutes: 2));
      } on TimeoutException {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        CustomSnackBar.showError(context, 'Network Error, Please try again');
      } finally {
        await sub.cancel();
      }
    }();
  }

  int _mapYearToInt(String label) {
    final normalized = label.toLowerCase();
    if (normalized.contains('first') || normalized.contains('الأولى')) return 1;
    if (normalized.contains('second') || normalized.contains('الثانية')) {
      return 2;
    }
    if (normalized.contains('third') || normalized.contains('الثالثة')) {
      return 3;
    }
    if (normalized.contains('fourth') || normalized.contains('الرابعة')) {
      return 4;
    }
    if (normalized.contains('fifth') || normalized.contains('الخامسة')) {
      return 5;
    }
    if (normalized.contains('sixth') || normalized.contains('السادسة')) {
      return 6;
    }
    if (normalized.contains('seventh') || normalized.contains('السابعة')) {
      return 7;
    }
    return 1;
  }

  int _mapSemesterToInt(String label) {
    final normalized = label.toLowerCase();
    if (normalized.contains('first') || normalized.contains('الأول')) return 1;
    if (normalized.contains('second') || normalized.contains('الثاني')) {
      return 2;
    }
    return 1;
  }

  List<domain.ResourceItem> _mapResourcesToDomain(List<ResourceItem> items) {
    return items.map((r) {
      final mappedType = _mapResourceType(r.type);
      final String url = r.url ?? r.filePath ?? '';
      final int? sizeMb = (r.type == ResourceType.pdf && r.filePath != null)
          ? _tryComputeFileSizeMB(r.filePath!)
          : null;
      return domain.ResourceItem(
        id: r.id,
        type: mappedType,
        title: r.title,
        url: url,
        fileSizeMB: sizeMb,
        createdAt: DateTime.now(),
      );
    }).toList();
  }

  domain.ResourceType _mapResourceType(ResourceType type) {
    switch (type) {
      case ResourceType.image:
        return domain.ResourceType.image;
      case ResourceType.pdf:
        return domain.ResourceType.pdf;
      case ResourceType.book:
        return domain.ResourceType.bookLink;
      case ResourceType.link:
        return domain.ResourceType.bookLink;
      case ResourceType.video:
        return domain.ResourceType.youtubeLink;
      case ResourceType.audio:
        return domain.ResourceType.record;
    }
  }

  int? _tryComputeFileSizeMB(String path) {
    try {
      final file = File(path);
      if (!file.existsSync()) return null;
      final bytes = file.lengthSync();
      return (bytes / (1024 * 1024)).ceil();
    } catch (_) {
      return null;
    }
  }

  List<domain.LectureSchedule> _mapLectureScheduleToDomain(
    Map<String, Map<String, String>> schedule,
  ) {
    final List<domain.LectureSchedule> lectures = [];
    schedule.forEach((dayLabel, timeMap) {
      final domain.DayOfWeek day = _mapDayLabelToEnum(dayLabel);
      final domain.TimeOfDay start = _parseTimeString(timeMap['from'] ?? '');
      final domain.TimeOfDay end = _parseTimeString(timeMap['to'] ?? '');
      lectures.add(
        domain.LectureSchedule(
          id: UniqueKey().toString(),
          day: day,
          startTime: start,
          endTime: end,
          location: null,
        ),
      );
    });
    return lectures;
  }

  domain.DayOfWeek _mapDayLabelToEnum(String label) {
    final l = label.toLowerCase();
    if (l.contains('sat') || l.contains('السبت')) {
      return domain.DayOfWeek.saturday;
    }
    if (l.contains('sun') || l.contains('الأحد')) {
      return domain.DayOfWeek.sunday;
    }
    if (l.contains('mon') || l.contains('الاثنين')) {
      return domain.DayOfWeek.monday;
    }
    if (l.contains('tue') || l.contains('الثلاثاء')) {
      return domain.DayOfWeek.tuesday;
    }
    if (l.contains('wed') || l.contains('الأربعاء')) {
      return domain.DayOfWeek.wednesday;
    }
    if (l.contains('thu') || l.contains('الخميس')) {
      return domain.DayOfWeek.thursday;
    }
    if (l.contains('fri') || l.contains('الجمعة')) {
      return domain.DayOfWeek.friday;
    }
    return domain.DayOfWeek.saturday;
  }

  domain.TimeOfDay _parseTimeString(String value) {
    // Expected like "1:30 PM" or "13:05"
    if (value.isEmpty) return const domain.TimeOfDay(hour: 0, minute: 0);
    final parts = value.split(' ');
    final timePart = parts[0];
    final ampm = parts.length > 1 ? parts[1].toUpperCase() : '';
    final hm = timePart.split(':');
    int hour = int.tryParse(hm[0]) ?? 0;
    final int minute = int.tryParse(hm.length > 1 ? hm[1] : '0') ?? 0;
    if (ampm == 'PM' && hour < 12) hour += 12;
    if (ampm == 'AM' && hour == 12) hour = 0;
    return domain.TimeOfDay(hour: hour, minute: minute);
  }
}

class _SavingDialog extends StatelessWidget {
  const _SavingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.getCardColorTwo(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomLoadingWidget(height: 30),
            heightBox(12),
            Text(context.tr.saving_project,
                style: Styles.font14PrimaryColorTextBold(context)),
            heightBox(12),
            Text(
              context.tr.please_wait_upload,
              style: Styles.font12GreyBold(context),
            ),
          ],
        ),
      ),
    );
  }
}
