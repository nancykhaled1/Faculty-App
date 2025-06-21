import 'dart:convert';

import 'package:faculty/data/models/response/academic_year_model.dart';
import 'package:faculty/data/models/response/newsModel.dart';
import 'package:faculty/data/remote/api/api_constant.dart';
import 'package:faculty/data/models/response/vision_mission_model.dart';
import 'package:faculty/data/models/response/faculty_info_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/model/request/loginRequest.dart';
import 'package:faculty/data/remote/model/response/DepartmentResponse.dart';
import 'package:faculty/data/remote/model/response/LoginResponse.dart';
import 'package:faculty/data/remote/model/response/StudentResponse.dart';
import 'package:faculty/data/remote/model/response/UserDataesponse.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../../local/preferences.dart';
import '../model/request/studentRegisterRequest.dart';
import '../model/request/updatedataRequest.dart';
import '../model/response/AlumniRegisterResponse.dart';
import '../model/response/NotificationResponse.dart';
import '../model/response/StudentPortalResponse.dart';
import '../model/response/UpdataDataResponse.dart';
import '../model/response/errors.dart';
import '../model/response/studentRegisterResponse.dart';
import 'api_constant.dart';
import 'failures.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager? getInstance() {
    _instance ??= ApiManager._();
    return _instance;
  }

  static Future<List<VisionMissionModel>> getVisionMission() async {
    final url = Uri.parse(ApiConstant.baseUrl + ApiConstant.visionMission);
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final decoded = utf8.decode(response.bodyBytes);
        final List<dynamic> json = jsonDecode(decoded);
        return json.map((item) => VisionMissionModel.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse JSON: ${e.toString()}\nResponse body: ${response.body}');
      }
    } else {
      throw Exception('Failed to load vision and mission. Status code: ${response.statusCode}\nResponse body: ${response.body}');
    }
  }

  static Future<List<NewsModel>> getNews() async {
    final url = Uri.parse(ApiConstant.baseUrl + ApiConstant.news);
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final decoded = utf8.decode(response.bodyBytes);
        final List<dynamic> json = jsonDecode(decoded);
        return json.map((item) => NewsModel.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse JSON: ${e.toString()}\nResponse body: ${response.body}');
      }
    } else {
      throw Exception('Failed to load news. Status code: ${response.statusCode}\nResponse body: ${response.body}');
    }
  }

  static Future<AcademicYearModel> getAcademicYear(int id) async {
    final url = Uri.parse('${ApiConstant.baseUrl}${ApiConstant.academicYears}$id/');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final decoded = utf8.decode(response.bodyBytes);
        final json = jsonDecode(decoded);
        return AcademicYearModel.fromJson(json);
      } catch (e) {
        throw Exception('Failed to parse JSON: ${e.toString()}\nResponse body: ${response.body}');
      }
    } else {
      throw Exception('Failed to load academic year. Status code: ${response.statusCode}\nResponse body: ${response.body}');
    }
  }

  static Future<List<FacultyInfoModel>> getFacultyInfo() async {
    final url = Uri.parse(ApiConstant.baseUrl + ApiConstant.facultyInfo);
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final decoded = utf8.decode(response.bodyBytes);
        final List<dynamic> json = jsonDecode(decoded);
        return json.map((item) => FacultyInfoModel.fromJson(item)).toList();
      } catch (e) {
        throw Exception('Failed to parse JSON: ${e.toString()}\nResponse body: ${response.body}');
      }
    } else {
      throw Exception('Failed to load faculty info. Status code: ${response.statusCode}\nResponse body: ${response.body}');
    }
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

        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.studentRegisterApi);

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

        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.alumniRegisterApi);

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

        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.loginApi);

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
      Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.depatmentApi);
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
      Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.studentApi);
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
      Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.portalApi);
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

  static Future<Either<RegisterError, UserDataResponse>> fetchGraduationProfile(String token) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.dataApi);


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

        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.notificationApi);


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



  static Future<Either<Failures, UpdataDataResponse>> updateData(
      String token,
      UpdateDataRequest request,
      ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.updateDataApi);
        var requestMultipart = http.MultipartRequest("PATCH", url);

        requestMultipart.headers.addAll({
          "Authorization": "Bearer $token",
        });

        // 🧠 إرسال الحقول الأساسية
        requestMultipart.fields['username'] = request.username;
        requestMultipart.fields['employment_status'] = request.employmentStatus;

        // 🛡️ إرسال الإيميل فقط لو مختلف عن القديم
        final savedEmail = SharedPrefsHelper.prefs.getString('email');
        if ((request.email ?? '').trim().toLowerCase() != (savedEmail ?? '').trim().toLowerCase()) {
          requestMultipart.fields['email'] = request.email!;
        }

        // ✏️ إرسال الحقول الاختيارية
        if ((request.jobName ?? '').isNotEmpty) {
          requestMultipart.fields['job_name'] = request.jobName!;
        }

        if ((request.companyEmail ?? '').isNotEmpty) {
          requestMultipart.fields['company_email'] = request.companyEmail!;
        }

        if ((request.companyPhone ?? '').isNotEmpty) {
          requestMultipart.fields['company_phone'] = request.companyPhone!;
        }

        if ((request.companyLink ?? '').isNotEmpty) {
          requestMultipart.fields['company_link'] = request.companyLink!;
        }

        if ((request.aboutCompany ?? '').isNotEmpty) {
          requestMultipart.fields['about_company'] = request.aboutCompany!;
        }

        if ((request.location ?? '').isNotEmpty) {
          requestMultipart.fields['location'] = request.location!;
        }

        // 📎 CV (ملف)
        if (request.cv != null && request.cv!.isNotEmpty) {
          requestMultipart.files.add(
            await http.MultipartFile.fromPath('cv', request.cv!),
          );
        }

        var streamedResponse = await requestMultipart.send();
        var response = await http.Response.fromStream(streamedResponse);

        print('📡 Response status: ${response.statusCode}');
        print('📄 Response body: ${response.body}');

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final updateDataResponse = UpdataDataResponse.fromJson(jsonResponse);
          return Right(updateDataResponse);
        } else {
          final errorMsg = jsonResponse["email"]?[0] ??
              jsonResponse["message"] ??
              "حدث خطأ في السيرفر";
          return Left(ServerError(errorMessage: errorMsg));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: "Exception: $e"));
      }
    } else {
      return Left(NetworkError(errorMessage: 'من فضلك تحقق من الاتصال بالإنترنت'));
    }
  }




}
