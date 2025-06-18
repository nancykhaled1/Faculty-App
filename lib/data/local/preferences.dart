import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const _usernameKey = 'username';
  static const _emailKey = 'email';
  static const _employmentStatusKey = 'employment_status';
  static const _jobKey = 'jobName';
  static const _emailCompanyKey = 'companyEmail';
  static const _phoneKey = 'companyPhone';
  static const _urlKey = 'companyLink';
  static const _descriptionKey = 'aboutCompany';
  static const _cvKey = 'cv';
  static const _locationKey = 'location';



  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }



  static Future<void> saveUserData({
    required String username,
    required String email,
    required String employmentStatus,
    String? jobName,
    String? companyEmail,
    String? companyPhone,
    String? companyLink,
    String? aboutCompany,
    dynamic cv,
    String? location
  }) async {

    print('jobName: $jobName');
    print('companyEmail: $companyEmail');
    print('companyPhone: $companyPhone');
    print('companyLink: $companyLink');
    print('aboutCompany: $aboutCompany');
    print('location: $location');



    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_employmentStatusKey, employmentStatus);

    await prefs.remove(_jobKey);
    await prefs.remove(_emailCompanyKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_urlKey);
    await prefs.remove(_descriptionKey);

    await prefs.setString(_jobKey, jobName ?? '');
    await prefs.setString(_emailCompanyKey, companyEmail ?? '');
    await prefs.setString(_phoneKey, companyPhone ?? '');
    await prefs.setString(_urlKey, companyLink ?? '');
    await prefs.setString(_descriptionKey, aboutCompany ?? '');
    await prefs.setString(_cvKey, cv ?? '');
    await prefs.setString(_locationKey, location ?? '');

  }


  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey),
      'email': prefs.getString(_emailKey),
      'employment_status': prefs.getString(_employmentStatusKey),
      'jobName': prefs.getString(_jobKey),
      'companyEmail': prefs.getString(_emailCompanyKey),
      'companyPhone': prefs.getString(_phoneKey),
      'companyLink': prefs.getString(_urlKey),
      'aboutCompany': prefs.getString(_descriptionKey),
      'cv': prefs.getString(_cvKey),
      'location': prefs.getString(_locationKey),


      // ✅ أضف السطر دا
      'token': prefs.getString('token'),
    };
  }


  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_employmentStatusKey);
    await prefs.remove(_jobKey);
    await prefs.remove(_emailCompanyKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_urlKey);
    await prefs.remove(_descriptionKey);
    await prefs.remove(_cvKey);
    await prefs.remove(_locationKey);

  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}
