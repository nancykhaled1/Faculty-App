

import 'package:faculty/domain/entities/LoginEntity.dart';

import '../../register/alumniregisterscreen.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{
  String? loadingMessage;
  LoginLoadingState({required this.loadingMessage});
}
class LoginErrorState extends LoginStates{
  String? errorMessage;
  LoginErrorState({required this.errorMessage});
}
class LoginSuccessState extends LoginStates{
  LoginEntity response;
  LoginSuccessState({required this.response});
}