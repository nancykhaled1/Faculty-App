import 'package:faculty/domain/entities/userDataEntity.dart';

import '../../../domain/entities/updateDataEntity.dart';

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
  UserDataResponseEntity userDataResponseEntity;
  UserDataSuccessStates({required this.userDataResponseEntity});
}

// class UpdateDataSuccessStates extends UserDataStates {
//   UpdataDataResponseEntity updateDataResponseEntity;
//   UpdateDataSuccessStates({required this.updateDataResponseEntity});
// }

class UpdateDataSuccessStates extends UserDataStates {
  final UserDataResponseEntity updateDataResponseEntity;

  UpdateDataSuccessStates({required this.updateDataResponseEntity});
}

