import 'package:get_it/get_it.dart';
import 'package:study_box/feature/add_subject/data/repos/subject_repository_impl.dart';
import 'package:study_box/feature/add_subject/data/service/subject_service.dart';
import 'package:study_box/feature/add_subject/domain/repos/subject_repository.dart';
import 'package:study_box/feature/add_subject/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:study_box/feature/subject_details/data/service/additional_notes_service.dart';
import 'package:study_box/feature/subject_details/presentation/manager/additional_note_cubit/additional_notes_cubit.dart';
import 'package:study_box/feature/add_subject/data/service/storage_resource_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service_impl.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository_impl.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Supabase Client
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  /////////////// Services ////////////////////////
  // Auth Service
  getIt.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(),
  );

  // Subject Service
  getIt.registerLazySingleton<SubjectService>(
    () => SubjectService(supabaseClient: getIt()),
  );

  // Storage Resource Service
  getIt.registerLazySingleton<StorageResourceService>(
    () => StorageResourceService(supabaseClient: getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<AdditionalNotesService>(
    () => AdditionalNotesService(
      supabaseClient: getIt<SupabaseClient>(),
    ),
  );

  /////////////// Repositories ///////////////////////
  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // Subject Repository
  getIt.registerLazySingleton<SubjectRepository>(
    () => SubjectRepositoryImpl(subjectService: getIt()),
  );

  /////////////// Cubits ///////////////////////
  // Auth Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt()),
  );

  // subject Cubit
  getIt.registerFactory<SubjectCubit>(
    () => SubjectCubit(
      subjectRepository: getIt(),
      storageService: getIt<StorageResourceService>(),
    ),
  );

  // Additional Notes Cubit
  getIt.registerFactory<AdditionalNotesCubit>(
    () => AdditionalNotesCubit(getIt<AdditionalNotesService>()),
  );
}

Future<void> resetDependencies() async {
  await getIt.reset();
  await initDependencies();
}
