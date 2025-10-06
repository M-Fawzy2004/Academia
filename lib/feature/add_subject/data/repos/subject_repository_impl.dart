import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/feature/add_subject/data/model/subject_model.dart';
import 'package:study_box/feature/add_subject/data/service/subject_service.dart';
import 'package:study_box/feature/add_subject/domain/entities/subject_entity.dart';
import 'package:study_box/feature/add_subject/domain/repos/subject_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectService subjectService;

  SubjectRepositoryImpl({required this.subjectService});

  @override
  Future<Either<Failure, String>> addSubject(SubjectEntity subject) async {
    try {
      final subjectModel = SubjectModel.fromEntity(subject);
      final id = await subjectService.addSubject(subjectModel);
      return Right(id);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubjectEntity>>> getSubjects(
    int year,
    int semester,
  ) async {
    try {
      final subjects = await subjectService.getSubjectsByYearAndSemester(
        year,
        semester,
      );
      return Right(subjects);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubjectEntity>>> getAllSubjects() async {
    try {
      final subjects = await subjectService.getAllSubjects();
      return Right(subjects);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSubject(SubjectEntity subject) async {
    try {
      final subjectModel = SubjectModel.fromEntity(subject);
      await subjectService.updateSubject(subjectModel);
      return const Right(unit);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSubject(String id) async {
    try {
      await subjectService.deleteSubject(id);
      return const Right(unit);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubjectEntity>> getSubjectById(String id) async {
    try {
      final subject = await subjectService.getSubjectById(id);
      return Right(subject);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkSubscriptionLimits(
    SubscriptionTier tier,
    ResourceType resourceType,
    int currentCount, {
    int? fileSizeMB,
  }) async {
    try {
      final limits = SubscriptionLimits.limits[tier]!;

      switch (resourceType) {
        case ResourceType.image:
          if (currentCount >= limits.maxImagesPerSubject) {
            return Left(LimitExceededFailure(
              message: 'Image limit exceeded for ${tier.name} plan',
            ));
          }
          break;
        case ResourceType.pdf:
          if (currentCount >= limits.maxPdfsPerSubject) {
            return Left(LimitExceededFailure(
              message: 'PDF limit exceeded for ${tier.name} plan',
            ));
          }
          if (fileSizeMB != null && fileSizeMB > limits.maxPdfSizeMB) {
            return Left(LimitExceededFailure(
              message: 'PDF size exceeds ${limits.maxPdfSizeMB}MB limit',
            ));
          }
          break;
        case ResourceType.youtubeLink:
        case ResourceType.bookLink:
          if (currentCount >= limits.maxLinksPerSubject) {
            return Left(LimitExceededFailure(
              message: 'Link limit exceeded for ${tier.name} plan',
            ));
          }
          break;
        case ResourceType.record:
          break;
      }

      return const Right(true);
    } catch (e) {
      return Left(ValidationFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionTier>> getUserSubscriptionTier() async {
    try {
      final tier = await subjectService.getUserSubscriptionTier();
      return Right(tier);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Create user profile - add this method
  Future<Either<Failure, Unit>> createUserProfile({
    required String fullName,
    String? avatarUrl,
    SubscriptionTier tier = SubscriptionTier.free,
  }) async {
    try {
      await subjectService.createUserProfile(
        fullName: fullName,
        avatarUrl: avatarUrl,
        tier: tier,
      );
      return const Right(unit);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Get user profile - add this method
  Future<Either<Failure, Map<String, dynamic>?>> getUserProfile() async {
    try {
      final profile = await subjectService.getUserProfile();
      return Right(profile);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}