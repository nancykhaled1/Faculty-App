import 'package:faculty/ui/students/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/studentPortalEntity.dart';
import '../../../domain/usecase/get_studentportal_usecase.dart';


class StudentPortalViewModel extends Cubit<StudentStates> {
  GetStudentPortalUseCase getStudentPortalUseCase;

  StudentPortalViewModel({required this.getStudentPortalUseCase})
      : super(StudentInitialStates());
  List<StudentPortalResponseEntity> allPortals = [];
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
            print("✅ Scholarships length: ${scholarShip.length}");
            print("✅ activity length: ${activity.length}");
            print("📦 Scholarships data: $scholarShip");

            emit(StudentPortalSuccessStates(studentPortalResponseEntity: response));
      },
    );
  }

  void filterPortal() {
    scholarShip = allPortals
        .where((element) =>
    element.types == "المنح الدراسية" )
        .toList();

    activity = allPortals
        .where((element) =>
    element.types == "انشطة الطلابية" )
        .toList();



  }

  void selectPortal() {
    filterPortal();
  }
}