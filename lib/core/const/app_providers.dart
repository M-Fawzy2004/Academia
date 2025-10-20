import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/feature/add_subject/data/service/storage_resource_service.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:study_box/feature/image_details/data/service/image_gallery_service.dart';
import 'package:study_box/feature/image_details/presentation/manager/cubit/image_gallery_cubit.dart';
import 'package:study_box/feature/reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:study_box/feature/subject_details/presentation/manager/additional_note_cubit/additional_notes_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppProviders {
  /// Register View Provider
  static Widget registerView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Email Verification View Provider
  static Widget emailVerificationView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Login View Provider
  static Widget loginView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Forget Password View Provider
  static Widget forgetPasswordView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Main View Provider
  static Widget mainView({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<SubjectCubit>(
          create: (_) => getIt<SubjectCubit>()..getAllSubjects(),
        ),
        BlocProvider<ReminderCubit>(
          create: (_) => getIt<ReminderCubit>()..getAllReminders(),
        ),
      ],
      child: child,
    );
  }

  /// Profile View Provider
  static Widget profileView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Add Subject View Provider
  static Widget addSubjectView({required Widget child}) {
    return BlocProvider<SubjectCubit>(
      create: (_) => getIt<SubjectCubit>(),
      child: child,
    );
  }

  /// Subject Details View Provider
  static Widget subjectDetailsView({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubjectCubit>(
          create: (_) => getIt<SubjectCubit>(),
        ),
        BlocProvider<AdditionalNotesCubit>(
          create: (_) => getIt<AdditionalNotesCubit>(),
        ),
      ],
      child: child,
    );
  }

  /// PDF Details View Provider
  static Widget pdfDetailsView({required Widget child}) {
    return BlocProvider<SubjectCubit>(
      create: (_) => getIt<SubjectCubit>(),
      child: child,
    );
  }

  /// Image Details View Provider
  static Widget imageDetailsView({
    required String subjectId,
    required Widget child,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageGalleryCubit>(
          create: (_) => ImageGalleryCubit(
            imageGalleryService: ImageGalleryService(
              supabaseClient: Supabase.instance.client,
            ),
            storageService: StorageResourceService(
              supabaseClient: Supabase.instance.client,
            ),
            subjectId: subjectId,
          )..loadImages(),
        ),
        BlocProvider<SubjectCubit>(
          create: (_) => getIt<SubjectCubit>(),
        ),
      ],
      child: child,
    );
  }

  /// Reminder View Provider
  static Widget reminderView({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubjectCubit>(
          create: (_) => getIt<SubjectCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ReminderCubit>()..getAllReminders(),
        ),
      ],
      child: child,
    );
  }
}
