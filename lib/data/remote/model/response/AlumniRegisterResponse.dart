import 'dart:io';

import '../../../../domain/entities/alumniRegisterEntity.dart';

/// email : "nancy2@example.com"
/// username : "h12"
/// cv : null
/// employment_status : "employee"
/// job_name : "dklbkwbkvc"
/// location : "wsvncwlerkjnvc"
/// company_email : "sljl@email.com"
/// company_phone : "09389792"
/// company_link : "https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657"
/// about_company : "adgfewbvwetbeb"
/// is_active : false
/// id : 11

class AlumniRegisterResponse {
  AlumniRegisterResponse({
    this.email,
    this.username,
    this.cv,
    this.employmentStatus,
    this.jobName,
    this.location,
    this.companyEmail,
    this.companyPhone,
    this.companyLink,
    this.aboutCompany,
    this.isActive,
    this.id,});

  AlumniRegisterResponse.fromJson(dynamic json) {
    email = json['email'];
    username = json['username'];
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobName = json['job_name'];
    location = json['location'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyLink = json['company_link'];
    aboutCompany = json['about_company'];
    isActive = json['is_active'];
    id = json['id'];
  }
  String? email;
  String? username;
  dynamic cv;
  String? employmentStatus;
  String? jobName;
  String? location;
  String? companyEmail;
  String? companyPhone;
  String? companyLink;
  String? aboutCompany;
  bool? isActive;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['username'] = username;
    map['cv'] = cv;
    map['employment_status'] = employmentStatus;
    map['job_name'] = jobName;
    map['location'] = location;
    map['company_email'] = companyEmail;
    map['company_phone'] = companyPhone;
    map['company_link'] = companyLink;
    map['about_company'] = aboutCompany;
    map['is_active'] = isActive;
    map['id'] = id;
    return map;
  }


  AlumniRegisterResponseEntity toRegisterResultEntity() {
    return AlumniRegisterResponseEntity(
        email: email,
        username: username,
        id: id,
        companyEmail: companyEmail,
        companyLink: companyLink,
        companyPhone: companyPhone,
        cv: cv,
        jobName: jobName,
        location: location,
        aboutCompany: aboutCompany,
        employmentStatus: employmentStatus
    );
  }

}