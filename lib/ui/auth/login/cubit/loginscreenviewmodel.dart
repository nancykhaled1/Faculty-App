
import 'package:faculty/ui/auth/login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/remote/model/response/errors.dart';
import '../../../../domain/usecase/loginusercase.dart';

class LoginScreenViewModel extends Cubit<LoginStates>{
  LoginUseCase loginUseCase;
  LoginScreenViewModel({required this.loginUseCase}) : super (LoginInitialState());
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();
  bool isPasswordVisible = true;
  bool isChecked = false;

  void login()async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState(loadingMessage: 'Loading...'));
      var either = await loginUseCase.invoke(emailController.text, passwordController.text);
      either.fold((failure) {
        String errorMessage = _getErrorMessage(failure);
        emit(LoginErrorState(errorMessage: errorMessage));
      },
              (response) {
            emit(LoginSuccessState(response: response));
          });
    }
  }
}

String _getErrorMessage(RegisterError error) {
  if (error.nonFieldErrors != null && error.nonFieldErrors!.isNotEmpty) {
    return error.nonFieldErrors!.first;
  } else if (error.email != null && error.email!.isNotEmpty) {
    return error.email!.first;
  } else if (error.userType != null && error.userType!.isNotEmpty) {
    return error.userType!.first;
  } else if (error.detail != null && error.detail!.isNotEmpty) {
    return error.detail!;
  } else {
    return "حدث خطأ غير متوقع، حاول مرة أخرى.";
  }
}