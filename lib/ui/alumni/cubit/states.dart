import 'package:faculty/domain/entities/userDataEntity.dart';

abstract class UserDataStates{}
class UserDataInitialStates extends UserDataStates{}
class UserDataLoadingStates extends UserDataStates{
  String? loadingMessage;
  UserDataLoadingStates({required this.loadingMessage});
}
class UserDataErrorStates extends UserDataStates{
  String? errorMessage;
  UserDataErrorStates({required this.errorMessage});
}
class UserDataSuccessStates extends UserDataStates{
//CategoryEntity categoryEntity;
  UserDataResponseEntity userDataResponseEntity;
  UserDataSuccessStates({required this.userDataResponseEntity});
}
