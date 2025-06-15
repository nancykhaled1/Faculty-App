import 'package:faculty/domain/entities/studentPortalEntity.dart';

import '../../../domain/entities/studentEntity.dart';

abstract class StudentStates{}
class StudentInitialStates extends StudentStates{}
class StudentLoadingStates extends StudentStates{
  String? loadingMessage;
  StudentLoadingStates({required this.loadingMessage});
}
class StudentErrorStates extends StudentStates{
  String? errorMessage;
  StudentErrorStates({required this.errorMessage});
}
class StudentSuccessStates extends StudentStates{
//CategoryEntity categoryEntity;
  List<StudentResponseEntity> studentResponseEntity;
  StudentSuccessStates({required this.studentResponseEntity});
}

class StudentPortalSuccessStates extends StudentStates{
//CategoryEntity categoryEntity;
  List<StudentPortalResponseEntity> studentPortalResponseEntity;
  StudentPortalSuccessStates({required this.studentPortalResponseEntity});
}
