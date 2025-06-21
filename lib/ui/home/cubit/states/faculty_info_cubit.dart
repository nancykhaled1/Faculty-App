import 'package:faculty/data/models/response/faculty_info_model.dart';
import 'package:faculty/data/remote/api/api_manager.dart';
import 'package:faculty/ui/home/cubit/states/faculty_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacultyInfoCubit extends Cubit<FacultyInfoState> {
  FacultyInfoCubit() : super(FacultyInfoInitial());

  void getFacultyInfo() async {
    emit(FacultyInfoLoading());
    try {
      final facultyInfo = await ApiManager.getFacultyInfo();
      emit(FacultyInfoSuccess(facultyInfo));
    } catch (e) {
      emit(FacultyInfoError(e.toString()));
    }
  }
}