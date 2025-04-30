import 'package:flutter/cupertino.dart';

import 'job_info.dart';

class Alumni {
  String name;
  String email;
  String password;
  String employmentStatus;
  String? resumeFileName;
  JobInfo? jobInfo;

  Alumni({
    required this.name,
    required this.email,
    required this.password,
    required this.employmentStatus,
    this.resumeFileName,
    this.jobInfo,
  });

  factory Alumni.defaultAlumni() {
    return Alumni(
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


