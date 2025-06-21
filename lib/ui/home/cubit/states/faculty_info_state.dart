import 'package:faculty/data/models/response/faculty_info_model.dart';

abstract class FacultyInfoState {}

class FacultyInfoInitial extends FacultyInfoState {}

class FacultyInfoLoading extends FacultyInfoState {}

class FacultyInfoSuccess extends FacultyInfoState {
  final List<FacultyInfoModel> facultyInfo;

  FacultyInfoSuccess(this.facultyInfo);
}

class FacultyInfoError extends FacultyInfoState {
  final String message;

  FacultyInfoError(this.message);
}