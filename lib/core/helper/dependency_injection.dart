import 'package:get_it/get_it.dart';
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

  // uth Service
  getIt.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // Auth Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt()),
  );
}

void resetDependencies() {
  getIt.reset();
}
