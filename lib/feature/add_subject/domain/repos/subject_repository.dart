import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import '../entities/subject_entity.dart';

abstract class SubjectRepository {
  /// Add new subject to database and return created subject ID
  Future<Either<Failure, String>> addSubject(SubjectEntity subject);

  /// Get subjects by year and semester
  Future<Either<Failure, List<SubjectEntity>>> getSubjects(int year, int semester);

  /// Get all subjects for user
  Future<Either<Failure, List<SubjectEntity>>> getAllSubjects();

  /// Update existing subject
  Future<Either<Failure, Unit>> updateSubject(SubjectEntity subject);

  /// Delete subject by ID
  Future<Either<Failure, Unit>> deleteSubject(String id);

  /// Get subject by ID
  Future<Either<Failure, SubjectEntity>> getSubjectById(String id);

  /// Check subscription limits before adding
  Future<Either<Failure, bool>> checkSubscriptionLimits(
    SubscriptionTier tier,
    ResourceType resourceType,
    int currentCount, {
    int? fileSizeMB,
  });

  /// Get user's current subscription tier
  Future<Either<Failure, SubscriptionTier>> getUserSubscriptionTier();
}