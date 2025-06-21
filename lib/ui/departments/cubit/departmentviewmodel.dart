import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/usecase/get_all_dept_usecase.dart';
import 'package:faculty/ui/departments/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentScreenviewmodel extends Cubit<DepartmentStates> {
  GetAllDepartmentUseCase getAllDepartmentUseCase;

  DepartmentScreenviewmodel({required this.getAllDepartmentUseCase})
      : super(DepartmentInitialStates());

  List<DepartmentResponseEntity> departments = [];
  List<DoctorsDetailEntity> teachers = [];
  List<DoctorsDetailEntity> assistants = [];


  void getDepartment() async {
    emit(DepartmentLoadingStates(loadingMessage: 'Loading...'));
    var either = await getAllDepartmentUseCase.invoke();
    either.fold(
          (l) {
        emit(DepartmentErrorStates(errorMessage: l.errorMessage));
      },
          (response) {
        departments = response;

        // إذا أردت تقسيم المدرسين والمساعدين لقسم معين
        if (departments.isNotEmpty) {
          _filterDoctors(departments.first); // افتراضيًا القسم الأول
        }

        emit(DepartmentSuccessStates(departmentResponseEntity: response));
      },
    );
  }

  void _filterDoctors(DepartmentResponseEntity department) {
    teachers = [];
    assistants = [];

    if (department.doctorsDetail != null) {
      teachers = department.doctorsDetail!
          .where((doctor) => doctor.position?.trim() == 'مدرس')
          .toList();

      assistants = department.doctorsDetail!
          .where((doctor) => doctor.position?.trim() == 'مدرس مساعد')
          .toList();
    }
  }

  // لتحديث المدرسين بناءً على القسم المختار
  void selectDepartment(DepartmentResponseEntity department) {
    _filterDoctors(department);
   // emit(DepartmentDoctorFiltered()); // حالة وهمية لإعادة البناء
  }
}
