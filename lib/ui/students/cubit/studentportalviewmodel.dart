import 'package:faculty/ui/students/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/studentPortalEntity.dart';
import '../../../domain/usecase/get_studentportal_usecase.dart';


class StudentPortalViewModel extends Cubit<StudentStates> {
  GetStudentPortalUseCase getStudentPortalUseCase;

  StudentPortalViewModel({required this.getStudentPortalUseCase})
      : super(StudentInitialStates());
  List<StudentPortalResponseEntity> allPortals = []; // كل البيانات الجاية من الAPI
  List<StudentPortalResponseEntity> scholarShip = [];
  List<StudentPortalResponseEntity> activity = [];




  void getStudentPortal() async {
    emit(StudentLoadingStates(loadingMessage: 'Loading...'));
    var either = await getStudentPortalUseCase.invoke();
    either.fold(
          (l) {
        emit(StudentErrorStates(errorMessage: l.errorMessage));
      },
          (response) {
            allPortals = response;
            filterPortal();
        emit(StudentPortalSuccessStates(studentPortalResponseEntity: response));
      },
    );
  }

  void filterPortal() {
    scholarShip = allPortals
        .where((element) =>
    element.types == "المنح الدراسيه" )
        .toList();

    activity = allPortals
        .where((element) =>
    element.types == "الانشطه الطلابيه" )
        .toList();



  }

  void selectPortal() {
    filterPortal();
    // emit(DepartmentDoctorFiltered()); // حالة وهمية لإعادة البناء
  }
}