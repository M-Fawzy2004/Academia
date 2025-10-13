import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:study_box/core/error/failure.dart';
import 'package:study_box/feature/reminder/data/model/reminder_model.dart';
import 'package:study_box/feature/reminder/data/service/reminder_service.dart';
import 'package:study_box/feature/reminder/domain/enities/reminder_entity.dart';
import 'package:study_box/feature/reminder/domain/repo/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderService reminderService;

  ReminderRepositoryImpl({required this.reminderService});

  @override
  Future<Either<Failure, String>> addReminder(ReminderEntity reminder) async {
    try {
      final reminderModel = ReminderModel.fromEntity(reminder);
      final id = await reminderService.addReminder(reminderModel);
      return Right(id);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getAllReminders() async {
    try {
      final reminders = await reminderService.getAllReminders();
      return Right(reminders);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getRemindersByType(
      String type) async {
    try {
      final reminders = await reminderService.getRemindersByType(type);
      return Right(reminders);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getRemindersBySubject(
      String subjectId) async {
    try {
      final reminders = await reminderService.getRemindersBySubject(subjectId);
      return Right(reminders);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReminder(ReminderEntity reminder) async {
    try {
      final reminderModel = ReminderModel.fromEntity(reminder);
      await reminderService.updateReminder(reminderModel);
      return const Right(null);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReminder(String id) async {
    try {
      await reminderService.deleteReminder(id);
      return const Right(null);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleReminderCompletion(
      String id, bool isCompleted) async {
    try {
      await reminderService.toggleReminderCompletion(id, isCompleted);
      return const Right(null);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>>
      createRemindersFromSubjectLectures(
    String subjectId,
    String subjectName,
    List<dynamic> lectures,
  ) async {
    try {
      final reminders =
          await reminderService.createRemindersFromSubjectLectures(
        subjectId,
        subjectName,
        lectures,
      );
      return Right(reminders);
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
