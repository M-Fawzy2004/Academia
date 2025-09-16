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
        // Check if any connection is available
        final bool hasConnection =
            results.any((result) => result != ConnectivityResult.none);

        if (!_hasInternet && hasConnection) {
          // إذا كان الإنترنت راجع، حمل البيانات مرة أخرى
          _hasInternet = true;
          loadCourses();
        } else if (_hasInternet && !hasConnection) {
          // إذا انقطع الإنترنت
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

      // تحقق من الإنترنت أولاً
      final List<ConnectivityResult> connectivityResults =
          await Connectivity().checkConnectivity();

      // Check if any connection is available
      final bool hasConnection = connectivityResults
          .any((result) => result != ConnectivityResult.none);

      if (!hasConnection) {
        emit(CoursesNoInternet());
        return;
      }

      // محاكاة تحميل البيانات من API
      await Future.delayed(const Duration(seconds: 2));

      // بيانات تجريبية - استبدلها بـ API call حقيقي
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
          'title': 'مراجعة درس Flutter Widgets',
          'dueDate': DateTime.now().add(const Duration(hours: 2)),
          'course': 'Flutter Development',
        },
        {
          'title': 'حل تمارين UI Design',
          'dueDate': DateTime.now().add(const Duration(hours: 5)),
          'course': 'UI/UX Design',
        },
        {
          'title': 'إنهاء مشروع Backend',
          'dueDate': DateTime.now().add(const Duration(days: 1)),
          'course': 'Backend Development',
        },
      ],
      'motivationalQuote': {
        'text': 'النجاح هو نتيجة الاستعداد والفرصة والعمل الجاد',
        'author': 'محمد علي كلاي',
      },
    };
  }
}
