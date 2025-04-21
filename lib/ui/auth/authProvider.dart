import 'package:flutter/cupertino.dart';

import '../../data/local/alumni_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  Alumni? _alumni;
  Alumni? get alumni => _alumni;

  void setAlumni(Alumni user) {
    _alumni = user;
    notifyListeners();
  }

}
