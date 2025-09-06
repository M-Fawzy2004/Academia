part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state when app starts
class AuthInitial extends AuthState {}

// Loading state during authentication operations
class AuthLoading extends AuthState {}

// User is successfully authenticated
class AuthAuthenticated extends AuthState {
  final AuthModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// User is not authenticated
class AuthUnauthenticated extends AuthState {}

// Sign up completed successfully (needs email verification)
class AuthSignUpSuccess extends AuthState {
  final AuthModel user;

  const AuthSignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// Email verification completed successfully
class AuthEmailVerified extends AuthState {
  final String message;

  const AuthEmailVerified(this.message);

  @override
  List<Object?> get props => [message];
}

// Email sent successfully (verification or password reset)
class AuthEmailSent extends AuthState {
  final String message;

  const AuthEmailSent(this.message);

  @override
  List<Object?> get props => [message];
}

// Password reset email sent successfully
class AuthPasswordResetSent extends AuthState {
  final String message;

  const AuthPasswordResetSent(this.message);

  @override
  List<Object?> get props => [message];
}

// Password updated successfully
class AuthPasswordUpdated extends AuthState {
  final String message;

  const AuthPasswordUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

// Error occurred during authentication operation
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
