import 'package:faculty/domain/entities/studentEntity.dart';
import 'package:faculty/domain/usecase/get_studentservice_usecase.dart';
import 'package:faculty/ui/students/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote/model/response/StudentResponse.dart';
import '../ElectronicServicesBody.dart';
import '../StudentLifeBody.dart';
import '../StudyLifeBody.dart';

class StudentViewModel extends Cubit<StudentStates> {
  GetStudentServiceUseCase getStudentServiceUseCase;

  StudentViewModel({required this.getStudentServiceUseCase})
      : super(StudentInitialStates());

  List<String> categories = ["حياة دراسية", "خدمات الكترونية", "حياة طلابية"];
  String selectedType = "حياة دراسية";
  int selectedIndex = 0;

  List<String> categoryIcons = [
    'assets/icons/Community Students.svg',
    'assets/icons/electronicService.svg',
    'assets/icons/Life_Insurance.svg',

  ];
  List<Widget> get screens => [
    StudyLifeBody(services: studyLife),
    ElectronicServicesBody(services: electronicServices),
    StudentLifeBody(services: studentLife),
  ];


  List<StudentResponseEntity> allServices = []; // كل البيانات الجاية من الAPI
  List<StudentResponseEntity> electronicServices = [];
  List<StudentResponseEntity> studentLife = [];
  List<StudentResponseEntity> studyLife = [];


  void getStudentService() async {
    emit(StudentLoadingStates(loadingMessage: 'Loading...'));
    var either = await getStudentServiceUseCase.invoke();
    either.fold(
          (l) {
        emit(StudentErrorStates(errorMessage: l.errorMessage));
      },
          (response) {
            allServices = response;        // 🟢 هنا بنخزن البيانات
            filterServices();
            emit(StudentSuccessStates(studentResponseEntity: response));
      },
    );
  }

  void filterServices() {
    electronicServices = allServices
        .where((element) =>
    element.type == "بوابة الطلاب" && element.title == "خدمات الكترونية"  )
        .toList();

    // عشان تفصل studyLife و studentLife على حسب title
    studyLife = allServices
        .where((element) =>
    element.type == "بوابة الطلاب" && element.title == "حياه دراسية")
        .toList();

    studentLife = allServices
        .where((element) =>
    element.type == "بوابة الطلاب" && element.title == "حياه طلابية")
        .toList();

    print("Total services from API: ${allServices.length}");
    print("Electronic services: ${electronicServices.length}");
    print("Study life services: ${studyLife.length}");
    print("Student life services: ${studentLife.length}");
  }

  void selectService() {
    filterServices();
    // emit(DepartmentDoctorFiltered()); // حالة وهمية لإعادة البناء
  }

}