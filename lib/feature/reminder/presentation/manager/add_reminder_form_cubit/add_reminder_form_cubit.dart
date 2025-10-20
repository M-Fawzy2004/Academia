import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:uuid/uuid.dart';
part 'add_reminder_form_state.dart';

class AddReminderFormCubit extends Cubit<AddReminderFormState> {
  AddReminderFormCubit() : super(AddReminderFormState.initial());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void initializeForm(ReminderEntity? reminder) {
    titleController.text = reminder?.title ?? '';
    descriptionController.text = reminder?.description ?? '';

    final type = reminder?.type ?? ReminderType.task;
    final date = reminder?.date ?? DateTime.now();
    final priority = reminder?.priority ?? ReminderPriority.medium;
    
    TimeOfDay time;

    if (reminder != null) {
      final timeParts = reminder.time.split(':');
      time = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );
    } else {
      time = TimeOfDay.now();
    }

    emit(state.copyWith(
      selectedType: type,
      selectedDate: date,
      selectedTime: time,
      selectedPriority: priority,
    ));
  }

  void updateType(ReminderType type) {
    emit(state.copyWith(selectedType: type));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updatePriority(ReminderPriority priority) {
    emit(state.copyWith(selectedPriority: priority));
  }

  String? validateTitle() {
    if (titleController.text.trim().isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  ReminderEntity buildReminderEntity(ReminderEntity? existingReminder) {
    final timeString =
        '${state.selectedTime.hour.toString().padLeft(2, '0')}:${state.selectedTime.minute.toString().padLeft(2, '0')}';

    return ReminderEntity(
      id: existingReminder?.id ?? const Uuid().v4(),
      userId: existingReminder?.userId ?? '',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: state.selectedDate,
      time: timeString,
      type: state.selectedType,
      isCompleted: existingReminder?.isCompleted ?? false,
      subjectId: null,
      notificationId: existingReminder?.notificationId,
      priority: state.selectedPriority,
      createdAt: existingReminder?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}