import 'package:faculty/data/remote/api/api_constant.dart';
import 'package:faculty/data/remote/model/response/DepartmentResponse.dart';

class AcademicYearModel {
  int? id;
  String? year;
  String? lectureSchedule;
  String? practicalExam;
  String? exam;
  String? seatingNumber;

  AcademicYearModel({
    this.id,
    this.year,
    this.lectureSchedule,
    this.practicalExam,
    this.exam,
    this.seatingNumber,
  });

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) {
    try {
      print('🔍 Parsing AcademicYearModel JSON: $json');
      
      return AcademicYearModel(
        id: _safeParseInt(json['id']),
        year: json['year']?.toString(),
        lectureSchedule: _prependBaseUrl(json['lecture_schedule']),
        practicalExam: _prependBaseUrl(json['practical_exam']),
        exam: _prependBaseUrl(json['exam']),
        seatingNumber: _prependBaseUrl(json['seating_number']),
      );
    } catch (e) {
      print('❌ Error parsing AcademicYearModel: $e');
      print('❌ JSON data: $json');
      return AcademicYearModel();
    }
  }

  static int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        // فحص إذا كان الـ string يحتوي على URL
        if (value.contains('://') || value.startsWith('//')) {
          print('⚠️ Warning: Attempting to parse URL as int: $value');
          return null;
        }
        return int.parse(value);
      } catch (e) {
        print('❌ Error parsing int from string: $value');
        print('❌ Error details: $e');
        return null;
      }
    }
    print('⚠️ Warning: Unknown type for int parsing: $value (${value.runtimeType})');
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['lecture_schedule'] = lectureSchedule;
    data['practical_exam'] = practicalExam;
    data['exam'] = exam;
    data['seating_number'] = seatingNumber;
    return data;
  }
}

String? _prependBaseUrl(dynamic url) {
  try {
    if (url == null) return null;
    
    String urlString = url.toString();
    if (urlString.isEmpty) return null;
    
    print('🔍 Processing URL: $urlString');
    
    // إذا كان URL يحتوي على http أو https، ارجعه كما هو
    if (urlString.startsWith('http://') || urlString.startsWith('https://')) {
      print('✅ Full URL detected: $urlString');
      return urlString;
    }
    
    // إذا كان URL يبدأ بـ //، أضف https:
    if (urlString.startsWith('//')) {
      String fullUrl = 'https:$urlString';
      print('✅ Protocol-relative URL converted: $fullUrl');
      return fullUrl;
    }
    
    // إذا كان URL نسبي، أضف baseUrl
    if (!urlString.startsWith('http')) {
      String fullUrl = 'https://smartcollegedmanhour-production.up.railway.app$urlString';
      print('✅ Relative URL converted: $fullUrl');
      return fullUrl;
    }
    
    return urlString;
  } catch (e) {
    print('❌ Error in _prependBaseUrl: $e');
    print('❌ URL value: $url');
    return null;
  }
}