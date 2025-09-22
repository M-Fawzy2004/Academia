part of 'subject_cubit.dart';

abstract  class SubjectState extends Equatable {
  const SubjectState();

  @override
  List<Object?> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectLoading extends SubjectState {}

class SubjectsLoaded extends SubjectState {
  final List<SubjectEntity> subjects;

  const SubjectsLoaded(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class SubjectLoaded extends SubjectState {
  final SubjectEntity subject;

  const SubjectLoaded(this.subject);

  @override
  List<Object?> get props => [subject];
}

class SubjectSuccess extends SubjectState {
  final String message;

  const SubjectSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SubjectError extends SubjectState {
  final String message;

  const SubjectError(this.message);

  @override
  List<Object?> get props => [message];
}
