import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_box/core/helper/dependency_injection.dart';
import 'package:study_box/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class AppProviders {
  /// Register View Provider
  static Widget registerView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Email Verification View Provider
  static Widget emailVerificationView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Login View Provider
  static Widget loginView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Forget Password View Provider
  static Widget forgetPasswordView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// Home View Provider
  static Widget mainView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }

  /// profile View Provider
  static Widget profileView({required Widget child}) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: child,
    );
  }
}
