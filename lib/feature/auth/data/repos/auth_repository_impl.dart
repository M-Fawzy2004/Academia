import 'package:dartz/dartz.dart';
import 'package:study_box/feature/auth/data/Services/supabase_auth_service.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthService _authService;

  const AuthRepositoryImpl(this._authService);

  // Create new user account with email verification
  @override
  Future<Either<String, AuthModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!_isValidEmail(email)) {
      return const Left('Please enter a valid email address');
    }

    if (password.length < 6) {
      return const Left('Password must be at least 6 characters long');
    }

    if (name.trim().isEmpty) {
      return const Left('Name is required');
    }

    return await _authService.signUp(
      email: email.trim(),
      password: password,
      name: name.trim(),
    );
  }

  // Authenticate user with email and password
  @override
  Future<Either<String, AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    if (!_isValidEmail(email)) {
      return const Left('Please enter a valid email address');
    }

    if (password.isEmpty) {
      return const Left('Password is required');
    }

    return await _authService.signIn(
      email: email.trim(),
      password: password,
    );
  }

  // Authenticate user with Google account
  @override
  Future<Either<String, AuthModel>> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  // Authenticate user with Apple account
  @override
  Future<Either<String, AuthModel>> signInWithApple() async {
    return await _authService.signInWithApple();
  }

  // Verify user email address with OTP token
  @override
  Future<Either<String, String>> verifyEmail({required String token}) async {
    if (token.trim().isEmpty) {
      return const Left('Verification code is required');
    }

    return await _authService.verifyEmail(token: token.trim());
  }

  // Send new email verification code
  @override
  Future<Either<String, String>> resendEmailVerification(
      {required String email}) async {
    if (!_isValidEmail(email)) {
      return const Left('Please enter a valid email address');
    }

    return await _authService.resendEmailVerification(email: email.trim());
  }

  // Send password reset link to user email
  @override
  Future<Either<String, String>> resetPassword({required String email}) async {
    if (!_isValidEmail(email)) {
      return const Left('Please enter a valid email address');
    }

    return await _authService.resetPassword(email: email.trim());
  }

  // Update user password with new one
  @override
  Future<Either<String, String>> updatePassword(
      {required String password}) async {
    if (password.length < 6) {
      return const Left('Password must be at least 6 characters long');
    }

    return await _authService.updatePassword(password: password);
  }

  // Get currently authenticated user data
  @override
  Future<Either<String, AuthModel>> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }

  // Update user profile information
  @override
  Future<Either<String, AuthModel>> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  }) async {
    if (name != null && name.trim().isEmpty) {
      return const Left('Name cannot be empty');
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
  Future<Either<String, void>> signOut() async {
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
