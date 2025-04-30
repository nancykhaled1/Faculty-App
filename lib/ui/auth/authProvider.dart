import 'package:flutter/cupertino.dart';

import '../../data/local/alumni_model.dart';
class AuthProvider with ChangeNotifier {
  bool isLoggedIn = false;
  String _userType = ""; // graduate or student or admin

  String get userType => _userType;

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

  Alumni? _alumni;
  Alumni? get alumni => _alumni;

  void setAlumni(Alumni user) {
    _alumni = user;
    notifyListeners();
  }

  void clearAlumni() {
    _alumni = null;
    notifyListeners();
  }
}

