import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, AuthModel>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthModel>> signInWithGoogle();
  Future<Either<Failure, AuthModel>> signInWithApple();
  Future<Either<Failure, String>> verifyEmail({
    required String token,
    String? email,
  });
  Future<Either<Failure, String>> verifyPasswordReset({
    required String token,
    String? email,
  });
  Future<Either<Failure, String>> resendEmailVerification({
    required String email,
  });
  Future<Either<Failure, String>> resetPassword({required String email});
  Future<Either<Failure, String>> updatePassword({required String password});
  Future<Either<Failure, AuthModel>> getCurrentUser();
  Future<Either<Failure, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  });
  Future<Either<Failure, void>> signOut();
}
