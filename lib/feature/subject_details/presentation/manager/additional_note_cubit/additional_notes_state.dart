part of 'additional_notes_cubit.dart';

abstract class AdditionalNotesState extends Equatable {
  const AdditionalNotesState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AdditionalNotesInitial extends AdditionalNotesState {}

// Loading states
class AdditionalNotesLoading extends AdditionalNotesState {}

class AdditionalNotesAdding extends AdditionalNotesState {}

class AdditionalNotesUpdating extends AdditionalNotesState {}

class AdditionalNotesDeleting extends AdditionalNotesState {}

// Success states
class AdditionalNotesLoaded extends AdditionalNotesState {
  final List<AdditionalNote> notes;

  const AdditionalNotesLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class AdditionalNoteAdded extends AdditionalNotesState {}

class AdditionalNoteUpdated extends AdditionalNotesState {}

class AdditionalNoteDeleted extends AdditionalNotesState {}

// Error state
class AdditionalNotesError extends AdditionalNotesState {
  final String message;

  const AdditionalNotesError({required this.message});

  @override
  List<Object?> get props => [message];
}