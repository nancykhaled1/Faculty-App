import 'package:faculty/data/remote/api/api_manager.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicTeamsCubit extends Cubit<AcademicTeamsState> {
  AcademicTeamsCubit() : super(AcademicTeamsInitial());

  void getAcademicYear(int id) async {
    emit(AcademicTeamsLoading());
    try {
      final academicYear = await ApiManager.getAcademicYear(id);
      emit(AcademicTeamsSuccess(academicYear));
    } catch (e) {
      emit(AcademicTeamsError(e.toString()));
    }
  }
}