import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/feature/auth/presentation/view/login_view.dart';
import 'package:study_box/feature/welcome/presentation/view/welcome_view.dart';
import 'package:study_box/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:study_box/feature/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const onboardingView = '/onboardingView';
  static const welcomeView = '/welcomeView';
  static const loginView = '/loginView';

  static var router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: onboardingView,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: welcomeView,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
    ],
  );
}
