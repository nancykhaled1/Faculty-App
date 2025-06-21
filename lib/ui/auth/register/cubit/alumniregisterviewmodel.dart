import 'dart:io';
import 'package:faculty/ui/auth/register/alumniregisterscreen.dart';
import 'package:faculty/ui/auth/register/cubit/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/remote/model/response/errors.dart';
import '../../../../domain/usecase/registerusecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlumniRegisterScreenViewModel extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;

  AlumniRegisterScreenViewModel({required this.registerUseCase})
      : super(RegisterInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController employmentController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailCompanyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();


  bool showDropdown = false; // تحكم في إظهار القائمة المنسدلة

  String selectedEmploymentStatus = "ادخل حاله التوظيف";

  bool isRePasswordVisible = true;

  bool isPasswordVisible = true;

  bool showField = false; // تحكم في إظهار السيرة الذاتية

  final formKey = GlobalKey<FormState>();

  final Map<String, String> employmentIcons = {
    "موظف": "assets/icons/user-tick.svg",
    "باحث عن عمل": "assets/icons/user-settings.svg",
    "غير موظف": "assets/icons/user-cross.svg",
    "طالب دراسات عليا": "assets/icons/user-shield.svg",
    "يعمل عمل حر": "assets/icons/user-heart.svg",
  };

  final List<String> global = [
    "داخل مصر",
    "خارج مصر",
  ];

  final Map<String, String> employmentOptionsMap = {
    "employee": "موظف",
    "unemployee": "غير موظف",
    "seeking_job": "باحث عن عمل",
    "postgraduate": "طالب دراسات عليا",
    "freelance": "يعمل عمل حر",
  };


  File? cv;
  String? resumeFilePath;
  String? userId;

  Future<String?> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> alumniRegister(AlumniRegisterData data) async {
    if (!formKey.currentState!.validate()) return;
    if (data.employmentStatus == "employee" && resumeFilePath == null) {
      emit(AlumniRegisterErrorState(errorMessage: "يرجى رفع السيرة الذاتية."));
      return;}
    final String arabicStatus = selectedEmploymentStatus;
    final String englishStatus = employmentOptionsMap.entries
        .firstWhere((entry) => entry.value == arabicStatus,
        orElse: () => MapEntry('unemployee', 'غير موظف'))
        .key;
    emit(AlumniRegisterLoadingState(loadingMessage: 'جارٍ إرسال البيانات...'));
    try {
      final result = await registerUseCase.alumniInvoke(
        data.username.trim(), data.email.trim(), data.password,
        data.repeatPassword, cv, englishStatus,
        jobController.text, locationController.text,
        emailCompanyController.text, phoneController.text, urlController.text, descriptionController.text,
      );result.fold((failure) {
          final errorMessage = _getErrorMessage(failure);
          emit(AlumniRegisterErrorState(errorMessage: errorMessage));
        },
            (user) { emit(AlumniRegisterSuccessState(response: user));},
      );}
    catch (e) {emit(RegisterErrorState(errorMessage: "حدث خطأ أثناء التسجيل. حاول مرة أخرى."));}}





  String _getErrorMessage(RegisterError error) {
    if (error.nonFieldErrors?.isNotEmpty ?? false) {
      return error.nonFieldErrors!.first;
    } else if (error.email?.isNotEmpty ?? false) {
      return error.email!.first;
    } else if (error.userType?.isNotEmpty ?? false) {
      return error.userType!.first;
    } else if (error.employmentStatus?.isNotEmpty ?? false) {
      return error.employmentStatus!.first;
    }
    return "حدث خطأ غير متوقع، حاول مرة أخرى.";
  }

  // void disposeControllers() {
  //   emailController.dispose();
  //   userNameController.dispose();
  //   passwordController.dispose();
  //   rePasswordController.dispose();
  //   employmentController.dispose();
  //   jobController.dispose();
  //   locationController.dispose();
  //   emailCompanyController.dispose();
  //   phoneController.dispose();
  //   urlController.dispose();
  //   descriptionController.dispose();
  //   userTypeController.dispose();
  // }

  Future<void> pickResumeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.single.path;
      if (path != null) {
        cv = File(path);
        resumeFilePath = result.files.single.path;
        resumeController.text = resumeFilePath ?? '';
        emit(ResumePickedState(fileName: resumeFilePath!));
      }
    } else {
      emit(ResumePickCancelledState());
    }
  }


  // Future<void> pickResumeFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     cv = File(result.files.single.path!); // ✅ هنا نخزن الملف في المتغير الأساسي
  //     resumeFilePath = result.files.single.path; // لو حابب تستخدمه في TextFormField مثلاً
  //     resumeController.text = resumeFilePath ?? '';
  //     emit(ResumePickedState(fileName: resumeFilePath!));
  //   } else {
  //     emit(ResumePickCancelledState());
  //   }
  // }



}
