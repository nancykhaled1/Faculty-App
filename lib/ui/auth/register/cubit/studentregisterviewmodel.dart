import 'package:faculty/data/remote/api/api_manager.dart';
import 'package:faculty/ui/auth/register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/remote/model/response/errors.dart';
import '../../../../domain/usecase/registerusecase.dart';
class StudentRegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase registerUseCase;

  StudentRegisterViewModel({required this.registerUseCase}) : super(RegisterInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  var formKey = GlobalKey<FormState>();




  void studentRegister() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState(loadingMessage: 'Loading...'));
      var either = await registerUseCase.studentInvoke(
          userNameController.text,
          emailController.text,
          passwordController.text,
          rePasswordController.text,
          userTypeController.text
      ); either.fold(
            (failure) {
          String errorMessage = _getErrorMessage(failure);
          emit(RegisterErrorState(errorMessage: errorMessage));
        }, (response) async {
          if (response.id != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', response.id.toString());
            print('✅ User ID saved: ${response.id}');
          } else {
            print('❌ response.id is null!');
          }
          emit(RegisterSuccessState(response: response));},);}}


  String _getErrorMessage(RegisterError error) {
    if (error.nonFieldErrors != null && error.nonFieldErrors!.isNotEmpty) {
      return error.nonFieldErrors!.first;
    } else if (error.email != null && error.email!.isNotEmpty) {
      return error.email!.first;
    } else if (error.userType != null && error.userType!.isNotEmpty) {
      return error.userType!.first;
    } else {
      return "حدث خطأ غير متوقع، حاول مرة أخرى.";
    }
  }

}







