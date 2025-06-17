import 'package:faculty/ui/auth/register/alumniregisterscreen.dart';
import 'package:flutter/cupertino.dart';
import '../../data/local/preferences.dart';
import '../../domain/entities/userDataEntity.dart';
class AuthProvider with ChangeNotifier {
  bool isLoggedIn = false;
  String _userType = ""; // graduate or student or admin

  String get userType => _userType;

 // UserDataResponseEntity? _alumni;


  UserDataResponseEntity? _alumni;
  String? _token;

  UserDataResponseEntity? get alumni => _alumni;
  String? get token => _token;


  String _employmentStatus = "موظف";

  String get employmentStatus => _employmentStatus;

  void setEmploymentStatus(String status) {
    _employmentStatus = status;
    notifyListeners();
  }

  void setAlumniData(UserDataResponseEntity newAlumni) {
    _alumni = newAlumni;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  // void setUserData(Alumni newAlumni, String newToken) {
  // alumni = newAlumni;
  // token = newToken;
  // notifyListeners();
  // }



  void login(String type) {
    isLoggedIn = true;
    _userType = type;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    _userType = "";
    notifyListeners();
  }

 // Alumni? get alumni => _alumni;

  void clearAlumni() {
    _alumni = null;
    notifyListeners();
  }

  AlumniRegisterData? _userData;

  void setUserData(AlumniRegisterData data) {
    _userData = data;
    notifyListeners();
  }

  AlumniRegisterData? get userData => _userData;


  Future<void> loadUserDataFromPrefs() async {
    final data = await SharedPrefsHelper.getUserData();

    if (data['username'] != null && data['email'] != null && data['employment_status'] != null) {
      _alumni = UserDataResponseEntity(
        graduationData: GraduationDataResponseEntity(
          employmentStatus: data['employment_status'],
          jobName: data['jobName'],
          companyEmail: data['companyEmail'],
          companyPhone: data['companyPhone'],
          companyLink: data['companyLink'],
          aboutCompany: data['aboutCompany'],
          user: UserResponseEntity(
            username: data['username'],
            email: data['email'],
          ),
          location: "", // حطي هنا location لو كنتي مخزناه في SharedPrefs
          // باقي القيم ممكن تبقي null عادي
        ),
      );

      _employmentStatus = data['employment_status'] ?? '';
      isLoggedIn = true;
      notifyListeners();
    }
  }



}

