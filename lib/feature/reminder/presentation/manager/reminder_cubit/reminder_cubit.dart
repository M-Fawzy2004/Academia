import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/domain/repo/reminder_repository.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final ReminderRepository reminderRepository;

  ReminderCubit({required this.reminderRepository}) : super(ReminderInitial());

  List<ReminderEntity> allReminders = [];
  String currentFilter = 'all';

  Future<void> getAllReminders() async {
    emit(ReminderLoading());

    final result = await reminderRepository.getAllReminders();

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminders) {
        allReminders = reminders;
        emit(ReminderLoaded(reminders: reminders));
      },
    );
  }

  Future<void> filterReminders(String filterType) async {
    currentFilter = filterType.toLowerCase();

    if (currentFilter == 'all') {
      emit(ReminderLoaded(reminders: allReminders));
      return;
    }

    emit(ReminderLoading());

    final result = await reminderRepository.getRemindersByType(currentFilter);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminders) => emit(ReminderLoaded(reminders: reminders)),
    );
  }

  Future<void> getRemindersBySubject(String subjectId) async {
    emit(ReminderLoading());

    final result = await reminderRepository.getRemindersBySubject(subjectId);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminders) => emit(ReminderLoaded(reminders: reminders)),
    );
  }

  Future<void> addReminder(ReminderEntity reminder) async {
    emit(ReminderActionLoading());

    final result = await reminderRepository.addReminder(reminder);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (id) {
        emit(const ReminderActionSuccess(
            message: 'Reminder added successfully'));
        getAllReminders();
      },
    );
  }

  Future<void> updateReminder(ReminderEntity reminder) async {
    emit(ReminderActionLoading());

    final result = await reminderRepository.updateReminder(reminder);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (_) {
        emit(const ReminderActionSuccess(
            message: 'Reminder updated successfully'));
        getAllReminders();
      },
    );
  }

  Future<void> deleteReminder(String id) async {
    emit(ReminderActionLoading());

    final result = await reminderRepository.deleteReminder(id);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (_) {
        emit(const ReminderActionSuccess(
            message: 'Reminder deleted successfully'));
        getAllReminders();
      },
    );
  }

  Future<void> toggleReminderCompletion(String id, bool isCompleted) async {
    final result =
        await reminderRepository.toggleReminderCompletion(id, isCompleted);

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (_) {
        final updatedReminders = allReminders.map((reminder) {
          if (reminder.id == id) {
            return reminder.copyWith(isCompleted: isCompleted);
          }
          return reminder;
        }).toList();

        allReminders = updatedReminders;
        emit(ReminderLoaded(reminders: updatedReminders));
      },
    );
  }

  Future<void> createRemindersFromSubjectLectures({
    required String subjectId,
    required String subjectName,
    required List<dynamic> lectures,
  }) async {
    emit(ReminderActionLoading());

    final result = await reminderRepository.createRemindersFromSubjectLectures(
      subjectId,
      subjectName,
      lectures,
    );

    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminders) {
        emit(ReminderActionSuccess(
          message: '${reminders.length} lecture reminders created successfully',
        ));
        getAllReminders();
      },
    );
  }
}
