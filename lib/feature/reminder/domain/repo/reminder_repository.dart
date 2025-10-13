import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<Either<Failure, String>> addReminder(ReminderEntity reminder);
  Future<Either<Failure, List<ReminderEntity>>> getAllReminders();
  Future<Either<Failure, List<ReminderEntity>>> getRemindersByType(String type);
  Future<Either<Failure, List<ReminderEntity>>> getRemindersBySubject(String subjectId);
  Future<Either<Failure, void>> updateReminder(ReminderEntity reminder);
  Future<Either<Failure, void>> deleteReminder(String id);
  Future<Either<Failure, void>> toggleReminderCompletion(String id, bool isCompleted);
  Future<Either<Failure, List<ReminderEntity>>> createRemindersFromSubjectLectures(
    String subjectId,
    String subjectName,
    List<dynamic> lectures,
  );
}