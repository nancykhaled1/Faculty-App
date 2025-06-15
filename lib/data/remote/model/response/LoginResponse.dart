import 'package:faculty/domain/entities/LoginEntity.dart';

import 'errors.dart';

/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MTgyMTM2NCwiaWF0IjoxNzQ5MjI5MzY0LCJqdGkiOiIyYTA5MjBjODI2YWU0MDY3ODc0YzY2OGYzNjE0ZGJmYyIsInVzZXJfaWQiOjYsInVzZXJfdHlwZSI6IkdyYWR1YXRpb24iLCJ1cGRhdGVQYXNzd29yZCI6MCwidXBkYXRlTmFtZSI6MX0.elj4a_ehZc9zu77xMS-GMoMSYN98QYEtp4WiXfOwZQQ"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwNTI1MzY0LCJpYXQiOjE3NDkyMjkzNjQsImp0aSI6ImEwN2ZlMDgxZGEwNjQxYjdhN2QwMzM2ZTcxMjYwYWQwIiwidXNlcl9pZCI6NiwidXNlcl90eXBlIjoiR3JhZHVhdGlvbiIsInVwZGF0ZVBhc3N3b3JkIjowLCJ1cGRhdGVOYW1lIjoxfQ.bFWCl5-dhBf3BME_ttHspoMvcxXmw-EgCr48aM2CFU0"

class LoginResponse {
  LoginResponse({
      this.refresh,
    this.registerError,
      this.access,});

  LoginResponse.fromJson(dynamic json) {
    refresh = json['refresh'];
    access = json['access'];
    registerError = json['registerError'] != null
        ? RegisterError.fromJson(json['registerError'])
        : null;


  }
  String? refresh;
  String? access;
  RegisterError? registerError;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    map['registerError'] = registerError?.toJson();


    return map;
  }

  LoginEntity toAuthResultEntity() {
    return LoginEntity(
        access: access,
       refresh: refresh
       // userEntity: user?.toUserEntity()
    );
  }
}