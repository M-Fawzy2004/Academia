import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_box/feature/auth/data/model/auth_model.dart';
import 'package:study_box/feature/auth/data/repos/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  // Initialize authentication state by checking current user
  Future<void> initializeAuth() async {
    emit(AuthLoading());

    final result = await _authRepository.getCurrentUser();
    result.fold(
      (error) {
        if (error.contains('verify your email')) {
          emit(AuthEmailNotVerified());
        } else {
          emit(AuthUnauthenticated());
        }
      },
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Create new user account with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    if (password != confirmPassword) {
      emit(const AuthError('Passwords do not match'));
      return;
    }

    emit(AuthLoading());

    final result = await _authRepository.signUp(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthSignUpSuccess(user)),
    );
  }

  // Authenticate user with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (error) {
        if (error.contains('verify your email')) {
          emit(AuthEmailNotVerified());
        } else {
          emit(AuthError(error));
        }
      },
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Authenticate user with Google OAuth
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    final result = await _authRepository.signInWithGoogle();

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Authenticate user with Apple OAuth
  Future<void> signInWithApple() async {
    emit(AuthLoading());

    final result = await _authRepository.signInWithApple();

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Verify user email with OTP code
  Future<void> verifyEmail({
    required String token,
     BuildContext? context,
    String? email,
  }) async {
    emit(AuthLoading());

    final result = await _authRepository.verifyEmail(
      token: token,
      email: email, 
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (message) {
        emit(AuthEmailVerified(message));
        initializeAuth();
      },
    );
  }

  // Verify user password reset with OTP code
  Future<void> verifyPasswordReset({
    required String token,
    String? email,
  }) async {
    emit(AuthLoading());

    final result = await _authRepository.verifyPasswordReset(
      token: token,
      email: email,
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (message) => emit(AuthEmailVerified(message)), 
    );
  }

  // Resend email verification code to user
  Future<void> resendEmailVerification({required String email}) async {
    emit(AuthLoading());

    final result = await _authRepository.resendEmailVerification(email: email);

    result.fold(
      (error) => emit(AuthError(error)),
      (message) => emit(AuthEmailSent(message)),
    );
  }

  // Send password reset email to user
  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());

    final result = await _authRepository.resetPassword(email: email);

    result.fold(
      (error) => emit(AuthError(error)),
      (message) => emit(AuthPasswordResetSent(message)),
    );
  }

  // Update user password with new one
  Future<void> updatePassword({
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(const AuthError('Passwords do not match'));
      return;
    }

    emit(AuthLoading());

    final result = await _authRepository.updatePassword(password: password);

    result.fold(
      (error) => emit(AuthError(error)),
      (message) => emit(AuthPasswordUpdated(message)),
    );
  }

  // Update user profile information
  Future<void> updateProfile({
    String? name,
    String? profileImage,
    String? university,
    String? college,
  }) async {
    emit(AuthLoading());

    final result = await _authRepository.updateProfile(
      name: name,
      profileImage: profileImage,
      university: university,
      college: college,
    );

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Sign out current user from application
  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await _authRepository.signOut();

    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  // Clear current error state
  void clearError() {
    if (state is AuthError) {
      emit(AuthInitial());
    }
  }

  // Refresh current user data
  Future<void> refreshUser() async {
    if (state is AuthAuthenticated) {
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (error) => emit(AuthError(error)),
        (user) => emit(AuthAuthenticated(user)),
      );
    }
  }
}