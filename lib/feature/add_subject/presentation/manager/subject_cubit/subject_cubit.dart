import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/domain/repos/subject_repository.dart';

part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit({required this.subjectRepository}) : super(SubjectInitial());

  final SubjectRepository subjectRepository;

  /// Update last accessed
  Future<void> updateLastAccessed(String subjectId) async {
    if (state is SubjectsLoaded) {
      final subjects = (state as SubjectsLoaded).subjects;

      final updatedSubjects = subjects.map((subject) {
        if (subject.id == subjectId) {
          return subject.copyWith(
            lastAccessedAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
        }
        return subject;
      }).toList();

      emit(SubjectsLoaded(updatedSubjects));

      final updatedSubject = updatedSubjects.firstWhere(
        (s) => s.id == subjectId,
      );
      await subjectRepository.updateSubject(updatedSubject);
    }
  }

  /// Add subject
  Future<void> addSubject(SubjectEntity subject) async {
    emit(SubjectLoading());

    final tierResult = await subjectRepository.getUserSubscriptionTier();
    await tierResult.fold(
      (failure) async => emit(SubjectError(failure.message)),
      (tier) async {
        final limits = SubscriptionLimits.limits[tier]!;
        final allSubjectsResult = await subjectRepository.getAllSubjects();

        await allSubjectsResult.fold(
          (failure) async => emit(SubjectError(failure.message)),
          (allSubjects) async {
            if (allSubjects.length >= limits.maxSubjects) {
              emit(
                  SubjectError('Subject limit exceeded for ${tier.name} plan'));
              return;
            }

            final result = await subjectRepository.addSubject(subject);
            result.fold(
              (failure) => emit(SubjectError(failure.message)),
              (_) => emit(const SubjectSuccess('Subject added successfully')),
            );
          },
        );
      },
    );
  }

  // Get subjects by year and semester
  Future<void> getSubjectsByYearAndSemester(int year, int semester) async {
    emit(SubjectLoading());

    final result = await subjectRepository.getSubjects(year, semester);
    result.fold(
      (failure) => emit(SubjectError(failure.message)),
      (subjects) => emit(SubjectsLoaded(subjects)),
    );
  }

  /// Get all subjects
  Future<void> getAllSubjects() async {
    emit(SubjectLoading());

    final result = await subjectRepository.getAllSubjects();
    result.fold(
      (failure) => emit(SubjectError(failure.message)),
      (subjects) => emit(SubjectsLoaded(subjects)),
    );
  }

  /// Update existing subject
  Future<void> updateSubject(SubjectEntity subject) async {
    emit(SubjectLoading());

    final result = await subjectRepository.updateSubject(subject);
    result.fold(
      (failure) => emit(SubjectError(failure.message)),
      (_) => emit(const SubjectSuccess('Subject updated successfully')),
    );
  }

  /// Delete subject
  Future<void> deleteSubject(String id) async {
    emit(SubjectLoading());

    final result = await subjectRepository.deleteSubject(id);
    result.fold(
      (failure) => emit(SubjectError(failure.message)),
      (_) => emit(const SubjectSuccess('Subject deleted successfully')),
    );
  }

  /// Get subject by ID
  Future<void> getSubjectById(String id) async {
    emit(SubjectLoading());

    final result = await subjectRepository.getSubjectById(id);
    result.fold(
      (failure) => emit(SubjectError(failure.message)),
      (subject) => emit(SubjectLoaded(subject)),
    );
  }

  /// Add resource to subject with validation
  Future<void> addResourceToSubject(
    String subjectId,
    ResourceItem resource,
  ) async {
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    await subjectResult.fold(
      (failure) async => emit(SubjectError(failure.message)),
      (subject) async {
        final tierResult = await subjectRepository.getUserSubscriptionTier();
        await tierResult.fold(
          (failure) async => emit(SubjectError(failure.message)),
          (tier) async {
            final currentCount =
                subject.resources.where((r) => r.type == resource.type).length;

            final limitCheck = await subjectRepository.checkSubscriptionLimits(
              tier,
              resource.type,
              currentCount,
              fileSizeMB: resource.fileSizeMB,
            );

            await limitCheck.fold(
              (failure) async => emit(SubjectError(failure.message)),
              (_) async {
                final updatedResources = [...subject.resources, resource];
                final updatedSubject = SubjectEntity(
                  id: subject.id,
                  name: subject.name,
                  code: subject.code,
                  year: subject.year,
                  semester: subject.semester,
                  doctorName: subject.doctorName,
                  creditHours: subject.creditHours,
                  notes: subject.notes,
                  resources: updatedResources,
                  lectures: subject.lectures,
                  color: subject.color,
                  createdAt: subject.createdAt,
                  updatedAt: DateTime.now(),
                  lastAccessedAt: subject.lastAccessedAt,
                );

                final updateResult =
                    await subjectRepository.updateSubject(updatedSubject);
                updateResult.fold(
                  (failure) => emit(SubjectError(failure.message)),
                  (_) =>
                      emit(const SubjectSuccess('Resource added successfully')),
                );
              },
            );
          },
        );
      },
    );
  }

  /// Remove resource from subject
  Future<void> removeResourceFromSubject(
    String subjectId,
    String resourceId,
  ) async {
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    await subjectResult.fold(
      (failure) async => emit(SubjectError(failure.message)),
      (subject) async {
        final updatedResources =
            subject.resources.where((r) => r.id != resourceId).toList();

        final updatedSubject = SubjectEntity(
          id: subject.id,
          name: subject.name,
          code: subject.code,
          year: subject.year,
          semester: subject.semester,
          doctorName: subject.doctorName,
          creditHours: subject.creditHours,
          notes: subject.notes,
          resources: updatedResources,
          lectures: subject.lectures,
          color: subject.color,
          createdAt: subject.createdAt,
          updatedAt: DateTime.now(),
          lastAccessedAt: subject.lastAccessedAt,
        );

        final updateResult =
            await subjectRepository.updateSubject(updatedSubject);
        updateResult.fold(
          (failure) => emit(SubjectError(failure.message)),
          (_) => emit(const SubjectSuccess('Resource removed successfully')),
        );
      },
    );
  }

  /// Add lecture schedule to subject
  Future<void> addLectureToSubject(
    String subjectId,
    LectureSchedule lecture,
  ) async {
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    await subjectResult.fold(
      (failure) async => emit(SubjectError(failure.message)),
      (subject) async {
        final updatedLectures = [...subject.lectures, lecture];
        final updatedSubject = SubjectEntity(
          id: subject.id,
          name: subject.name,
          code: subject.code,
          year: subject.year,
          semester: subject.semester,
          doctorName: subject.doctorName,
          creditHours: subject.creditHours,
          notes: subject.notes,
          resources: subject.resources,
          lectures: updatedLectures,
          color: subject.color,
          createdAt: subject.createdAt,
          updatedAt: DateTime.now(),
          lastAccessedAt: subject.lastAccessedAt,
        );

        final updateResult =
            await subjectRepository.updateSubject(updatedSubject);
        updateResult.fold(
          (failure) => emit(SubjectError(failure.message)),
          (_) => emit(const SubjectSuccess('Lecture added successfully')),
        );
      },
    );
  }

  /// Remove lecture from subject
  Future<void> removeLectureFromSubject(
    String subjectId,
    String lectureId,
  ) async {
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    await subjectResult.fold(
      (failure) async => emit(SubjectError(failure.message)),
      (subject) async {
        final updatedLectures =
            subject.lectures.where((l) => l.id != lectureId).toList();

        final updatedSubject = SubjectEntity(
          id: subject.id,
          name: subject.name,
          code: subject.code,
          year: subject.year,
          semester: subject.semester,
          doctorName: subject.doctorName,
          creditHours: subject.creditHours,
          notes: subject.notes,
          resources: subject.resources,
          lectures: updatedLectures,
          color: subject.color,
          createdAt: subject.createdAt,
          updatedAt: DateTime.now(),
          lastAccessedAt: subject.lastAccessedAt,
        );

        final updateResult =
            await subjectRepository.updateSubject(updatedSubject);
        updateResult.fold(
          (failure) => emit(SubjectError(failure.message)),
          (_) => emit(const SubjectSuccess('Lecture removed successfully')),
        );
      },
    );
  }
}
