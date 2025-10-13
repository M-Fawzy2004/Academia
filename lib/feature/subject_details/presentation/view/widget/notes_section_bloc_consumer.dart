import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/subject_details/presentation/manager/additional_note_cubit/additional_notes_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/view/widget/notes_section.dart';

class NotesSectionBlocConsumer extends StatelessWidget {
  const NotesSectionBlocConsumer({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdditionalNotesCubit, AdditionalNotesState>(
      listener: (context, state) {
        if (state is AdditionalNoteAdded) {
          CustomSnackBar.showSuccess(context, context.tr.add_note_success);
        } else if (state is AdditionalNoteUpdated) {
          CustomSnackBar.showSuccess(context, context.tr.update_notes_success);
        } else if (state is AdditionalNoteDeleted) {
          CustomSnackBar.showSuccess(context, context.tr.delete_note_success);
        } else if (state is AdditionalNotesError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AdditionalNotesLoading) {
          return NotesSection(
            notes: const [],
            isLoading: true,
            subjectId: subjectId,
          );
        }

        if (state is AdditionalNotesLoaded) {
          return NotesSection(
            notes: state.notes,
            subjectId: subjectId,
            isLoading: false,
          );
        }

        if (state is AdditionalNotesError) {
          return NotesSection(
            notes: const [],
            subjectId: subjectId,
            isLoading: false,
            errorMessage: state.message,
          );
        }

        return NotesSection(
          notes: const [],
          subjectId: subjectId,
          isLoading: false,
        );
      },
    );
  }
}
