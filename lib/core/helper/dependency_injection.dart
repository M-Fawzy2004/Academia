import 'package:get_it/get_it.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service_impl.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository_impl.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

// Initialize all dependencies for authentication
Future<void> initDependencies() async {
  // Register Supabase Auth Service
  getIt.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(),
  );

  // Register Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // Register Auth Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt()),
  );
}

// Clear all registered dependencies
void resetDependencies() {
  getIt.reset();
}
