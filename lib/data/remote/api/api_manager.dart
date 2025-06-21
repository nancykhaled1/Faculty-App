import 'dart:convert';
import 'package:faculty/data/models/response/academic_year_model.dart';
import 'package:faculty/data/models/response/newsModel.dart';
import 'package:faculty/data/remote/api/api_constant.dart';
import 'package:faculty/data/models/response/vision_mission_model.dart';
import 'package:faculty/data/models/response/faculty_info_model.dart';

import 'package:http/http.dart' as http;

class ApiManager {
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
}