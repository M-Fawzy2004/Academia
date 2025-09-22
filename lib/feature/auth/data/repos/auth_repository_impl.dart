import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository.dart';
import 'package:study_box/l10n/app_localizations.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthService _authService;

  AppLocalizations? _appLocalizations;

  AuthRepositoryImpl(this._authService);

  // Create new user account with email verification
  @override
  Future<Either<Failure, AuthModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!_isValidEmail(email)) {
      return Left(
          ServerFailure(message: _appLocalizations!.please_enter_valid_email));
    }

    if (password.length < 6) {
      return Left(
          ServerFailure(message: _appLocalizations!.password_min_length));
    }

    if (name.trim().isEmpty) {
      return Left(ServerFailure(message: _appLocalizations!.name_is_required));
    }

    return await _authService.signUp(
      email: email.trim(),
      password: password,
      name: name.trim(),
    );
  }

  // Authenticate user with email and password
  @override
  Future<Either<Failure, AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    if (!_isValidEmail(email)) {
      return Left(
          ServerFailure(message: _appLocalizations!.please_enter_valid_email));
    }

    if (password.isEmpty) {
      return Left(
          ServerFailure(message: _appLocalizations!.password_is_required));
    }

    return await _authService.signIn(
      email: email.trim(),
      password: password,
    );
  }

  // Authenticate user with Google account
  @override
  Future<Either<Failure, AuthModel>> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  // Authenticate user with Apple account
  @override
  Future<Either<Failure, AuthModel>> signInWithApple() async {
    return await _authService.signInWithApple();
  }

  // Verify user email address with OTP token
  @override
  Future<Either<Failure, String>> verifyEmail({
    required String token,
    String? email,
  }) async {
    if (token.trim().isEmpty) {
      return Left(ServerFailure(
          message: _appLocalizations!.verification_code_required));
    }

    return await _authService.verifyEmail(
      token: token.trim(),
      email: email?.trim(),
    );
  }

  // Verify user password reset with OTP token
  @override
  Future<Either<Failure, String>> verifyPasswordReset({
    required String token,
    String? email,
  }) async {
    if (token.trim().isEmpty) {
      return Left(ServerFailure(
          message: _appLocalizations!.verification_code_required));
    }

    return await _authService.verifyPasswordReset(
      token: token.trim(),
      email: email?.trim(),
    );
  }

  // Send new email verification code
  @override
  Future<Either<Failure, String>> resendEmailVerification(
      {required String email}) async {
    if (!_isValidEmail(email)) {
      return Left(
          ServerFailure(message: _appLocalizations!.please_enter_valid_email));
    }

    return await _authService.resendEmailVerification(email: email.trim());
  }

  // Send password reset link to user email
  @override
  Future<Either<Failure, String>> resetPassword({required String email}) async {
    if (!_isValidEmail(email)) {
      return Left(
          ServerFailure(message: _appLocalizations!.please_enter_valid_email));
    }

    return await _authService.resetPassword(email: email.trim());
  }

  // Update user password with new one
  @override
  Future<Either<Failure, String>> updatePassword(
      {required String password}) async {
    if (password.length < 6) {
      return Left(
          ServerFailure(message: _appLocalizations!.password_min_length));
    }

    return await _authService.updatePassword(password: password);
  }

  // Get currently authenticated user data
  @override
  Future<Either<Failure, AuthModel>> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }

  // Update user profile information
  @override
  Future<Either<Failure, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  }) async {
    if (name != null && name.trim().isEmpty) {
      return Left(
          ServerFailure(message: _appLocalizations!.name_cannot_be_empty));
    }

    return await _authService.updateProfile(
      name: name?.trim(),
      profileImage: profileImage,
      university: university?.trim(),
      college: college?.trim(),
    );
  }

  // Sign out current user from app
  @override
  Future<Either<Failure, void>> signOut() async {
    return await _authService.signOut();
  }

  // Validate email format using regex
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
