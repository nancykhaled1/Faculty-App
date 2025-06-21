import 'package:faculty/data/remote/model/response/studentRegisterResponse.dart';
import 'package:faculty/domain/entities/alumniRegisterEntity.dart';

import '../../../../domain/entities/studentRegisterEntity.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{
  String? loadingMessage;
  RegisterLoadingState({required this.loadingMessage});
}
class RegisterErrorState extends RegisterStates{
  String? errorMessage;
  RegisterErrorState({required this.errorMessage});
}
class RegisterSuccessState extends RegisterStates{
  StudentRegisterResponseEntity response;
 RegisterSuccessState({required this.response});
}





class AlumniRegisterLoadingState extends RegisterStates{
  String? loadingMessage;
  AlumniRegisterLoadingState({required this.loadingMessage});
}
class AlumniRegisterErrorState extends RegisterStates{
  String? errorMessage;
  AlumniRegisterErrorState({required this.errorMessage});
}
class AlumniRegisterSuccessState extends RegisterStates{
  AlumniRegisterResponseEntity response;
  AlumniRegisterSuccessState({required this.response});
}
class ResumePickedState extends RegisterStates {
  final String fileName;

  ResumePickedState({required this.fileName});
}

class ResumePickCancelledState extends RegisterStates {}
