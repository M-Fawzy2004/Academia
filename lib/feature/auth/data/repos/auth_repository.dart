import 'package:dartz/dartz.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';

abstract class AuthRepository {
  Future<Either<String, AuthModel>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<String, AuthModel>> signIn({
    required String email,
    required String password,
  });

  Future<Either<String, AuthModel>> signInWithGoogle();
  Future<Either<String, AuthModel>> signInWithApple();
  Future<Either<String, String>> verifyEmail({
    required String token,
    String? email,
  });
  Future<Either<String, String>> verifyPasswordReset({
    required String token,
    String? email,
  });
  Future<Either<String, String>> resendEmailVerification({
    required String email,
  });
  Future<Either<String, String>> resetPassword({required String email});
  Future<Either<String, String>> updatePassword({required String password});
  Future<Either<String, AuthModel>> getCurrentUser();
  Future<Either<String, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  });
  Future<Either<String, void>> signOut();
}
