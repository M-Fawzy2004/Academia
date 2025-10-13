import 'package:equatable/equatable.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<ReminderEntity> reminders;

  const ReminderLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class ReminderError extends ReminderState {
  final String message;

  const ReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReminderActionSuccess extends ReminderState {
  final String message;

  const ReminderActionSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReminderActionLoading extends ReminderState {}