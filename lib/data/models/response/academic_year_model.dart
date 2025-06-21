import 'package:faculty/data/remote/api/api_constant.dart';

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
    return AcademicYearModel(
      id: json['id'],
      year: json['year'],
      lectureSchedule: _prependBaseUrl(json['lecture_schedule']),
      practicalExam: _prependBaseUrl(json['practical_exam']),
      exam: _prependBaseUrl(json['exam']),
      seatingNumber: _prependBaseUrl(json['seating_number']),
    );
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

String? _prependBaseUrl(String? url) {
  if (url != null && url.isNotEmpty && !url.startsWith('http')) {
    return '${ApiConstant.baseUrl}$url';
  }
  return url;
}