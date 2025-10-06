import 'package:equatable/equatable.dart';
import 'package:study_box/core/helper/custom_snack_bar.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  String get formattedMessage => CustomSnackBar.formatForBuild(message);

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class LimitExceededFailure extends Failure {
  const LimitExceededFailure({required super.message, super.code});
}
