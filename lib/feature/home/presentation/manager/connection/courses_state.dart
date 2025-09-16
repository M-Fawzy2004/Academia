part of 'courses_cubit.dart';

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<dynamic> courses;
  final Map<String, dynamic> userData;
  
  CoursesLoaded({
    required this.courses,
    required this.userData,
  });
}

class CoursesError extends CoursesState {
  final String message;
  final bool isNetworkError;
  
  CoursesError({
    required this.message,
    this.isNetworkError = false,
  });
}

class CoursesNoInternet extends CoursesState {}