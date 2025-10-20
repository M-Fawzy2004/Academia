part of 'add_reminder_form_cubit.dart';

class AddReminderFormState {
  final ReminderType selectedType;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ReminderPriority selectedPriority;

  AddReminderFormState({
    required this.selectedType,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPriority,
  });

  factory AddReminderFormState.initial() {
    return AddReminderFormState(
      selectedType: ReminderType.task,
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
      selectedPriority: ReminderPriority.medium,
    );
  }

  AddReminderFormState copyWith({
    ReminderType? selectedType,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    ReminderPriority? selectedPriority,
  }) {
    return AddReminderFormState(
      selectedType: selectedType ?? this.selectedType,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedPriority: selectedPriority ?? this.selectedPriority,
    );
  }
}