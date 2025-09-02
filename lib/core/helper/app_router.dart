import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/feature/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  // static const onboardingView = '/onboardingView';
  static var router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
    ],
  );
}
