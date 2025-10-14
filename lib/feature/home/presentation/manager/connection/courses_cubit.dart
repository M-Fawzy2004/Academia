import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _hasInternet = true;

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }

  void init() {
    _listenToConnectivity();
    loadCourses();
  }

  void _listenToConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final bool hasConnection =
            results.any((result) => result != ConnectivityResult.none);

        if (!_hasInternet && hasConnection) {
          _hasInternet = true;
          loadCourses();
        } else if (_hasInternet && !hasConnection) {
          _hasInternet = false;
          emit(CoursesNoInternet());
        }

        _hasInternet = hasConnection;
      },
    );
  }

  Future<void> loadCourses() async {
    try {
      emit(CoursesLoading());
      final List<ConnectivityResult> connectivityResults =
          await Connectivity().checkConnectivity();

      // Check if any connection is available
      final bool hasConnection = connectivityResults
          .any((result) => result != ConnectivityResult.none);

      if (!hasConnection) {
        emit(CoursesNoInternet());
        return;
      }
      await Future.delayed(const Duration(seconds: 2));

      final courses = _getMockCourses();
      final userData = _getMockUserData();

      emit(CoursesLoaded(
        courses: courses,
        userData: userData,
      ));
    } catch (e) {
      emit(CoursesError(
        message: 'حدث خطأ أثناء تحميل البيانات: ${e.toString()}',
        isNetworkError: false,
      ));
    }
  }

  void retry() {
    loadCourses();
  }

  List<dynamic> _getMockCourses() {
    return [
      {
        'id': 1,
        'title': 'Flutter Development',
        'progress': 75,
        'lessonsCount': 24,
        'completedLessons': 18,
      },
      {
        'id': 2,
        'title': 'UI/UX Design',
        'progress': 60,
        'lessonsCount': 20,
        'completedLessons': 12,
      },
      {
        'id': 3,
        'title': 'Backend Development',
        'progress': 40,
        'lessonsCount': 30,
        'completedLessons': 12,
      },
      {
        'id': 4,
        'title': 'Data Structures',
        'progress': 85,
        'lessonsCount': 15,
        'completedLessons': 13,
      },
      {
        'id': 5,
        'title': 'Mobile App Design',
        'progress': 90,
        'lessonsCount': 18,
        'completedLessons': 16,
      },
    ];
  }

  Map<String, dynamic> _getMockUserData() {
    return {
      'name': 'أحمد محمد',
      'studyStreak': 15,
      'completedCourses': 3,
      'totalHours': 120,
      'upcomingTasks': [
        {
          'title': 'Flutter Widgets',
          'dueDate': DateTime.now().add(const Duration(hours: 2)),
          'course': 'Flutter Development',
        },
        {
          'title': 'UI Design',
          'dueDate': DateTime.now().add(const Duration(hours: 5)),
          'course': 'UI/UX Design',
        },
        {
          'title': 'Backend',
          'dueDate': DateTime.now().add(const Duration(days: 1)),
          'course': 'Backend Development',
        },
      ],
      'motivationalQuote': {
        'text':
            'Success is the result of preparation, opportunity, and hard work.',
        'author': 'Muhammad Ali Clay',
      },
    };
  }
}
