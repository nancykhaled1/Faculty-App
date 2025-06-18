import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/model/request/loginRequest.dart';
import 'package:faculty/data/remote/model/response/DepartmentResponse.dart';
import 'package:faculty/data/remote/model/response/LoginResponse.dart';
import 'package:faculty/data/remote/model/response/StudentResponse.dart';
import 'package:faculty/data/remote/model/response/UserDataesponse.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../model/request/studentRegisterRequest.dart';
import '../model/response/AlumniRegisterResponse.dart';
import '../model/response/NotificationResponse.dart';
import '../model/response/StudentPortalResponse.dart';
import '../model/response/errors.dart';
import '../model/response/studentRegisterResponse.dart';
import 'api_constant.dart';
import 'failures.dart';

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager? getInstance() {
    _instance ??= ApiManager._();
    return _instance;
  }

  static Future<Either<RegisterError, StudentRegisterResponse>> studentRegister(
      String username,
      String email,
      String password,
      String repeatPassword,
      String userType,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.studentRegisterApi);

        var requestBody = StudentRegisterRequest(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          username: username,
          userType: userType,
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(url, body: requestBody.toJson());

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = StudentRegisterResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // هنا نستخدم fromJson لتحليل الأخطاء القادمة من السيرفر
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        return left(RegisterError(nonFieldErrors: ['Please check your internet connection.']));
      }
    } catch (e) {
      print('Exception: $e');
      return left(RegisterError(nonFieldErrors: ['Something went wrong: $e']));
    }
  }



  static Future<Either<RegisterError, AlumniRegisterResponse>> alumniRegister(
     // String userId,
      String username,
      String email,
      String password,
      String repeatPassword,
     // String userType,
      dynamic cv,
      String employmentStatus,
      String jobName,
      String location,
      String companyEmail,
      String companyPhone,
      String companyLink,
      String aboutCompany,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.alumniRegisterApi);

        var request = http.MultipartRequest('POST', url);

        request.fields.addAll({
         // 'user_id': userId,
          'username': username,
          'email': email,
          'password': password,
          'repeat_password': repeatPassword,
         // 'user_type': userType,
          'employment_status': employmentStatus,
          'job_name': jobName,
          'location': location,
          'company_email': companyEmail,
          'company_phone': companyPhone,
          'company_link': companyLink,
          'about_company': aboutCompany,
        });

        // ✅ إضافة ملف الـ CV إذا موجود
        if (cv != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'cv', // اسم الحقل المتوقع في الـ API
              cv.path,
              filename: basename(cv.path),
            ),
          );
        }

        print('Sending multipart request to: $url');
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return right(AlumniRegisterResponse.fromJson(jsonResponse));
        } else {
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        return left(RegisterError(nonFieldErrors: ['Please check your internet connection.']));
      }
    } catch (e) {
      print('Exception: $e');
      return left(RegisterError(nonFieldErrors: ['Something went wrong: $e']));
    }
  }



  static Future<Either<RegisterError, LoginResponse>> login(
      String email,
      String password
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.loginApi);

        var requestBody = LoginRequest(
          email: email ??'',
          password: password??'',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody.toJson()), // تأكد toJson يرجع Map<String, dynamic>
        );


        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = LoginResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // هنا نستخدم fromJson لتحليل الأخطاء القادمة من السيرفر
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        return left(RegisterError(nonFieldErrors: ['Please check your internet connection.']));
      }
    } catch (e) {
      print('Exception: $e');
      return left(RegisterError(nonFieldErrors: ['Something went wrong: $e']));
    }




  }



  static Future<Either<Failures, List<DepartmentResponse>>> getDepartment() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.depatmentApi);
      var response = await http.get(url);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonList = jsonDecode(response.body) as List;
        var departments = jsonList.map((e) => DepartmentResponse.fromJson(e)).toList();
        return Right(departments);
      } else {
        return Left(ServerError(errorMessage: "error in server"));
      }
    } else {
      return Left(NetworkError(errorMessage: 'please check connection'));
    }
  }

  static Future<Either<Failures, List<StudentResponse>>> getStudentService() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.studentApi);
      var response = await http.get(url);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonList = jsonDecode(response.body) as List;
        var student = jsonList.map((e) => StudentResponse.fromJson(e)).toList();
        return Right(student);
      } else {
        return Left(ServerError(errorMessage: "error in server"));
      }
    } else {
      return Left(NetworkError(errorMessage: 'please check connection'));
    }
  }

  static Future<Either<Failures, List<StudentPortalResponse>>> getStudentPortal() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.portalApi);
      var response = await http.get(url);
      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonList = jsonDecode(response.body) as List;
        var portal = jsonList.map((e) => StudentPortalResponse.fromJson(e)).toList();
        return Right(portal);
      } else {
        return Left(ServerError(errorMessage: "error in server"));
      }
    } else {
      return Left(NetworkError(errorMessage: 'please check connection'));
    }
  }

  static Future<Either<RegisterError, UserDataResponse>> fetchGraduationProfile(
  int id,
  String token,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.dataApi(id));


        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var getDataResponse = UserDataResponse.fromJson(jsonResponse);
          return right(getDataResponse);
        } else {
          // هنا نستخدم fromJson لتحليل الأخطاء القادمة من السيرفر
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        return left(RegisterError(nonFieldErrors: ['Please check your internet connection.']));
      }
    } catch (e) {
      print('Exception: $e');
      return left(RegisterError(nonFieldErrors: ['Something went wrong: $e']));
    }




  }


  static Future<Either<Failures, List<NotificationResponse>>> getNotification(String token) async {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.notificationApi);


        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

       // var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var jsonList = jsonDecode(response.body) as List;
          var getNotificationResponse = jsonList.map((e) => NotificationResponse.fromJson(e)).toList();
          return right(getNotificationResponse);
        } else {
          return Left(ServerError(errorMessage: "error in server"));
        }
      } else {
        return Left(NetworkError(errorMessage: 'please check connection'));
      }
  }
}
