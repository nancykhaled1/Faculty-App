import 'package:faculty/domain/entities/departmentEntity.dart';

abstract class DepartmentStates{}
class DepartmentInitialStates extends DepartmentStates{}
class DepartmentLoadingStates extends DepartmentStates{
  String? loadingMessage;
  DepartmentLoadingStates({required this.loadingMessage});
}
class DepartmentErrorStates extends DepartmentStates{
  String? errorMessage;
  DepartmentErrorStates({required this.errorMessage});
}
class DepartmentSuccessStates extends DepartmentStates{
//CategoryEntity categoryEntity;
  List<DepartmentResponseEntity> departmentResponseEntity;
  DepartmentSuccessStates({required this.departmentResponseEntity});
}
