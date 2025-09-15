part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthEmailNotVerified extends AuthState {}

class AuthSignUpSuccess extends AuthState {
  final AuthModel user;

  const AuthSignUpSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthEmailVerified extends AuthState {
  final String message;

  const AuthEmailVerified(this.message);

  @override
  List<Object> get props => [message];
}

class AuthEmailSent extends AuthState {
  final String message;

  const AuthEmailSent(this.message);

  @override
  List<Object> get props => [message];
}

class AuthPasswordResetSent extends AuthState {
  final String message;

  const AuthPasswordResetSent(this.message);

  @override
  List<Object> get props => [message];
}

class AuthPasswordUpdated extends AuthState {
  final String message;

  const AuthPasswordUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
