import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/feature/subject_details/data/service/additional_notes_service.dart';
import 'package:study_box/feature/subject_details/domain/entities/additional_note_entity.dart';

part 'additional_notes_state.dart';

class AdditionalNotesCubit extends Cubit<AdditionalNotesState> {
  final AdditionalNotesService _notesService;

  AdditionalNotesCubit(this._notesService) : super(AdditionalNotesInitial());

  /// Load notes for a specific subject
  Future<void> loadNotes(String subjectId) async {
    emit(AdditionalNotesLoading());
    try {
      final notes = await _notesService.getNotesBySubjectId(subjectId);
      emit(AdditionalNotesLoaded(notes: notes));
    } catch (e) {
      emit(AdditionalNotesError(message: CustomSnackBar.formatForBuild(e.toString())));
    }
  }

  /// Add a new note
  Future<void> addNote({
    required String subjectId,
    required String title,
    required String details,
  }) async {
    try {
      emit(AdditionalNotesAdding());
      await _notesService.addNote(
        subjectId: subjectId,
        title: title,
        details: details,
      );
      emit(AdditionalNoteAdded());
      // Reload notes after adding
      await loadNotes(subjectId);
    } catch (e) {
      emit(AdditionalNotesError(message: CustomSnackBar.formatForBuild(e.toString())));
    }
  }

  /// Update an existing note
  Future<void> updateNote({
    required String noteId,
    required String subjectId,
    required String title,
    required String details,
  }) async {
    try {
      emit(AdditionalNotesUpdating());
      await _notesService.updateNote(
        noteId: noteId,
        title: title,
        details: details,
      );
      emit(AdditionalNoteUpdated());
      // Reload notes after updating
      await loadNotes(subjectId);
    } catch (e) {
      emit(AdditionalNotesError(message: CustomSnackBar.formatForBuild(e.toString())));
    }
  }

  /// Delete a note
  Future<void> deleteNote({
    required String noteId,
    required String subjectId,
  }) async {
    try {
      emit(AdditionalNotesDeleting());
      await _notesService.deleteNote(noteId);
      emit(AdditionalNoteDeleted());
      // Reload notes after deleting
      await loadNotes(subjectId);
    } catch (e) {
      emit(AdditionalNotesError(message: CustomSnackBar.formatForBuild(e.toString())));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(AdditionalNotesInitial());
  }
}
