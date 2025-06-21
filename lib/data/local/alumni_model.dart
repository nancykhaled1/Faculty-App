import 'package:flutter/cupertino.dart';

import 'job_info.dart';

class Alumni {
  int id;
  String name;
  String email;
  String password;
  String employmentStatus;
  String? resumeFileName;
  JobInfo? jobInfo;

  Alumni({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.employmentStatus,
    this.resumeFileName,
    this.jobInfo,
  });

  factory Alumni.defaultAlumni() {
    return Alumni(
      id: -1 ,
      name: 'الاسم غير متاح',
      email: 'غير متاح',
      password: '',
      employmentStatus: 'غير محدد',
      resumeFileName: null,
      jobInfo: null,
    );
  }
}

enum UserType { student, alumni }


