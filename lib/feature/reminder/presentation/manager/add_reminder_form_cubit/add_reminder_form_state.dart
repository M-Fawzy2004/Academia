part of 'add_reminder_form_cubit.dart';

class AddReminderFormState {
  final ReminderType selectedType;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  AddReminderFormState({
    required this.selectedType,
    required this.selectedDate,
    required this.selectedTime,
  });

  factory AddReminderFormState.initial() {
    return AddReminderFormState(
      selectedType: ReminderType.task,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
    );
  }

  AddReminderFormState copyWith({
    ReminderType? selectedType,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    return AddReminderFormState(
      selectedType: selectedType ?? this.selectedType,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}
