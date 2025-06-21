import 'package:faculty/data/models/response/academic_year_model.dart';

abstract class AcademicTeamsState {}

class AcademicTeamsInitial extends AcademicTeamsState {}

class AcademicTeamsLoading extends AcademicTeamsState {}

class AcademicTeamsSuccess extends AcademicTeamsState {
  final AcademicYearModel academicYear;
  AcademicTeamsSuccess(this.academicYear);
}

class AcademicTeamsError extends AcademicTeamsState {
  final String message;
  AcademicTeamsError(this.message);
}