import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/domain/repos/subject_repository.dart';
import 'package:study_box/feature/add_subject/data/service/storage_resource_service.dart';

part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit({required this.subjectRepository, required this.storageService})
      : super(SubjectInitial());

  final SubjectRepository subjectRepository;
  final StorageResourceService storageService;

  /// Update last accessed
  Future<void> updateLastAccessed(String subjectId) async {
    if (isClosed) return;

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

      if (!isClosed) {
        emit(SubjectsLoaded(updatedSubjects));
      }

      final updatedSubject = updatedSubjects.firstWhere(
        (s) => s.id == subjectId,
      );
      await subjectRepository.updateSubject(updatedSubject);
    }
  }

  /// Add subject
  Future<void> addSubject(SubjectEntity subject) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final tierResult = await subjectRepository.getUserSubscriptionTier();
    if (isClosed) return;

    await tierResult.fold(
      (failure) async {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (tier) async {
        final limits = SubscriptionLimits.limits[tier]!;
        final allSubjectsResult = await subjectRepository.getAllSubjects();
        if (isClosed) return;

        await allSubjectsResult.fold(
          (failure) async {
            if (!isClosed) emit(SubjectError(failure.formattedMessage));
          },
          (allSubjects) async {
            if (allSubjects.length >= limits.maxSubjects) {
              if (!isClosed) {
                emit(SubjectError(
                    'Subject limit exceeded for ${tier.name} plan'));
              }
              return;
            }

            // Validate resource counts and sizes against limits BEFORE creating subject
            final int imagesCount = subject.resources
                .where((r) => r.type == ResourceType.image)
                .length;
            final int pdfsCount = subject.resources
                .where((r) => r.type == ResourceType.pdf)
                .length;
            final int linksCount = subject.resources
                .where((r) =>
                    r.type == ResourceType.youtubeLink ||
                    r.type == ResourceType.bookLink)
                .length;

            if (imagesCount > limits.maxImagesPerSubject) {
              if (!isClosed) {
                emit(
                    SubjectError('Image limit exceeded for ${tier.name} plan'));
              }
              return;
            }
            if (pdfsCount > limits.maxPdfsPerSubject) {
              if (!isClosed) {
                emit(SubjectError('PDF limit exceeded for ${tier.name} plan'));
              }
              return;
            }
            if (linksCount > limits.maxLinksPerSubject) {
              if (!isClosed) {
                emit(SubjectError('Link limit exceeded for ${tier.name} plan'));
              }
              return;
            }

            for (final r
                in subject.resources.where((r) => r.type == ResourceType.pdf)) {
              final size = r.fileSizeMB;
              if (size != null && size > limits.maxPdfSizeMB) {
                if (!isClosed) {
                  emit(SubjectError(
                      'PDF size exceeds ${limits.maxPdfSizeMB}MB limit for ${tier.name} plan'));
                }
                return;
              }
            }

            final result = await subjectRepository.addSubject(subject);
            if (isClosed) return;

            await result.fold(
              (failure) async {
                if (!isClosed) emit(SubjectError(failure.formattedMessage));
              },
              (createdSubjectId) async {
                // Upload local image/pdf files to storage and replace URLs
                final List<ResourceItem> updatedResources = [];
                for (final r in subject.resources) {
                  if (isClosed) return;

                  final isFileType = r.type == ResourceType.image ||
                      r.type == ResourceType.pdf;
                  final looksLikeHttp = r.url.startsWith('http://') ||
                      r.url.startsWith('https://');
                  if (isFileType && !looksLikeHttp) {
                    try {
                      final publicUrl = await storageService.uploadSubjectFile(
                        subjectId: createdSubjectId,
                        filePath: r.url,
                        overrideFileName: r.title,
                      );

                      if (isClosed) return;

                      // Optionally insert a row into resources table for centralized listing
                      await storageService.insertResourceRow(
                        subjectId: createdSubjectId,
                        type: r.type.name,
                        title: r.title,
                        url: publicUrl,
                        fileSizeMB: r.fileSizeMB,
                      );

                      if (isClosed) return;

                      updatedResources.add(
                        ResourceItem(
                          id: r.id,
                          type: r.type,
                          title: r.title,
                          url: publicUrl,
                          fileSizeMB: r.fileSizeMB,
                          createdAt: r.createdAt,
                        ),
                      );
                    } catch (e) {
                      if (!isClosed) {
                        emit(SubjectError('Failed to upload file: $e'));
                      }
                      return;
                    }
                  } else {
                    updatedResources.add(r);
                  }
                }

                if (isClosed) return;

                // Persist updated resources back to subject row
                final updatedSubject = SubjectEntity(
                  id: createdSubjectId,
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
                if (isClosed) return;

                updateResult.fold(
                  (failure) {
                    if (!isClosed) emit(SubjectError(failure.formattedMessage));
                  },
                  (_) {
                    if (!isClosed) {
                      emit(const SubjectSuccess('Subject added successfully'));
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  // Get subjects by year and semester
  Future<void> getSubjectsByYearAndSemester(int year, int semester) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final result = await subjectRepository.getSubjects(year, semester);
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (subjects) {
        if (!isClosed) emit(SubjectsLoaded(subjects));
      },
    );
  }

  /// Get all subjects
  Future<void> getAllSubjects() async {
    if (isClosed) return;
    emit(SubjectLoading());

    final result = await subjectRepository.getAllSubjects();
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (subjects) {
        if (!isClosed) emit(SubjectsLoaded(subjects));
      },
    );
  }

  /// Update existing subject
  Future<void> updateSubject(SubjectEntity subject) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final result = await subjectRepository.updateSubject(subject);
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (_) {
        if (!isClosed) {
          emit(const SubjectSuccess('Subject updated successfully'));
        }
      },
    );
  }

  /// Delete subject
  Future<void> deleteSubject(String id) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final result = await subjectRepository.deleteSubject(id);
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (_) {
        if (!isClosed) {
          emit(const SubjectSuccess('Subject deleted successfully'));
        }
      },
    );
  }

  /// Get subject by ID
  Future<void> getSubjectById(String id) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final result = await subjectRepository.getSubjectById(id);
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (subject) {
        if (!isClosed) emit(SubjectLoaded(subject));
      },
    );
  }

  /// Add resource to subject with validation
  Future<void> addResourceToSubject(
    String subjectId,
    ResourceItem resource,
  ) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    if (isClosed) return;

    await subjectResult.fold(
      (failure) async {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
      (subject) async {
        final tierResult = await subjectRepository.getUserSubscriptionTier();
        if (isClosed) return;

        await tierResult.fold(
          (failure) async {
            if (!isClosed) emit(SubjectError(failure.formattedMessage));
          },
          (tier) async {
            final currentCount =
                subject.resources.where((r) => r.type == resource.type).length;

            final limitCheck = await subjectRepository.checkSubscriptionLimits(
              tier,
              resource.type,
              currentCount,
              fileSizeMB: resource.fileSizeMB,
            );

            if (isClosed) return;

            await limitCheck.fold(
              (failure) async {
                if (!isClosed) emit(SubjectError(failure.formattedMessage));
              },
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
                if (isClosed) return;

                updateResult.fold(
                  (failure) {
                    if (!isClosed) emit(SubjectError(failure.formattedMessage));
                  },
                  (_) {
                    if (!isClosed) {
                      emit(const SubjectSuccess('Resource added successfully'));
                    }
                  },
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
    if (isClosed) return;
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    if (isClosed) return;

    await subjectResult.fold(
      (failure) async {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
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
        if (isClosed) return;

        updateResult.fold(
          (failure) {
            if (!isClosed) emit(SubjectError(failure.formattedMessage));
          },
          (_) {
            if (!isClosed) {
              emit(const SubjectSuccess('Resource removed successfully'));
            }
          },
        );
      },
    );
  }

  /// Add lecture schedule to subject
  Future<void> addLectureToSubject(
    String subjectId,
    LectureSchedule lecture,
  ) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    if (isClosed) return;

    await subjectResult.fold(
      (failure) async {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
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
        if (isClosed) return;

        updateResult.fold(
          (failure) {
            if (!isClosed) emit(SubjectError(failure.formattedMessage));
          },
          (_) {
            if (!isClosed) {
              emit(const SubjectSuccess('Lecture added successfully'));
            }
          },
        );
      },
    );
  }

  /// Remove lecture from subject
  Future<void> removeLectureFromSubject(
    String subjectId,
    String lectureId,
  ) async {
    if (isClosed) return;
    emit(SubjectLoading());

    final subjectResult = await subjectRepository.getSubjectById(subjectId);
    if (isClosed) return;

    await subjectResult.fold(
      (failure) async {
        if (!isClosed) emit(SubjectError(failure.formattedMessage));
      },
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
        if (isClosed) return;

        updateResult.fold(
          (failure) {
            if (!isClosed) emit(SubjectError(failure.formattedMessage));
          },
          (_) {
            if (!isClosed) {
              emit(const SubjectSuccess('Lecture removed successfully'));
            }
          },
        );
      },
    );
  }
}
