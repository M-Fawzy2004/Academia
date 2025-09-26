import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_box/core/const/app_providers.dart';
import 'package:study_box/feature/add_subject/presentation/view/add_subject_view.dart';
import 'package:study_box/feature/auth/presentation/view/forget_pass_view.dart';
import 'package:study_box/feature/auth/presentation/view/login_view.dart';
import 'package:study_box/feature/auth/presentation/view/register_view.dart';
import 'package:study_box/feature/auth/presentation/view/verf_email_view.dart';
import 'package:study_box/feature/home/data/model/quote_provider.dart';
import 'package:study_box/feature/home/presentation/view/home_view.dart';
import 'package:study_box/feature/main_home/presentation/view/main_view.dart';
import 'package:study_box/feature/profile/presentation/view/profile_view.dart';
import 'package:study_box/feature/subject/presentation/view/subject_view.dart';
import 'package:study_box/feature/welcome/presentation/view/welcome_view.dart';
import 'package:study_box/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:study_box/feature/splash/presentation/view/splash_view.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

abstract class AppRouter {
  static const onboardingView = '/onboardingView';
  static const welcomeView = '/welcomeView';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const forgetPassView = '/forgetPassView';
  static const verfEmailView = '/verfEmailView';
  static const mainView = '/mainView';
  static const homeView = '/homeView';
  static const profileView = '/profileView';
  static const addSubjectView = '/addSubjectView';
  static const subjectView = '/subjectView';

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
          return AppProviders.loginView(child: const LoginView());
        },
      ),
      GoRoute(
        path: registerView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.registerView(child: const RegisterView());
        },
      ),
      GoRoute(
        path: forgetPassView,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPassView();
        },
      ),
      GoRoute(
        path: verfEmailView,
        builder: (BuildContext context, GoRouterState state) {
          final String? email = state.uri.queryParameters['email'];
          return AppProviders.emailVerificationView(
            child: VerfEmailView(email: email),
          );
        },
      ),
      GoRoute(
        path: mainView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.mainView(
            child: ChangeNotifierProvider(
              create: (_) => QuoteProvider(),
              child: const MainView(),
            ),
          );
        },
      ),
      GoRoute(
        path: homeView,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: profileView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.profileView(child: const ProfileView());
        },
      ),
      GoRoute(
        path: addSubjectView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.addSubjectView(
            child: const AddSubjectView(),
          );
        },
      ),
      GoRoute(
        path: subjectView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.addSubjectView(
            child: const SubjectView(),
          );
        },
      ),
    ],
  );
}
