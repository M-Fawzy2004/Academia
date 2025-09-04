part of 'welcome_cubit.dart';

abstract class WelcomeState {}

class WelcomeInitial extends WelcomeState {}

class WelcomeAnimationsInitialized extends WelcomeState {}

class WelcomeAnimationsStarted extends WelcomeState {}

class WelcomeNavigateToLogin extends WelcomeState {}

class WelcomeNavigateToSignUp extends WelcomeState {}