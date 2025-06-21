import 'dart:io';

/// username : "h12"
/// email : "nancy2@example.com"
/// password : "123456"
/// user_type : "graduation"
/// repeat_password : "123456"
/// cv : ""
/// employment_status : "employee"
/// job_name : "dklbkwbkvc"
/// location : "wsvncwlerkjnvc"
/// company_email : "sljl@email.com"
/// company_phone : "234565576"
/// about_company : "adgfewbvwetbeb"
/// company_link : "https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657"

class AlumniRegisterRequest {
  AlumniRegisterRequest({
      this.username, 
      this.email, 
      this.password, 
      this.userType, 
      this.repeatPassword, 
      this.cv, 
      this.employmentStatus, 
      this.jobName, 
      this.location, 
      this.companyEmail, 
      this.companyPhone, 
      this.aboutCompany, 
      this.companyLink,});

  AlumniRegisterRequest.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    userType = json['user_type'];
    repeatPassword = json['repeat_password'];
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobName = json['job_name'];
    location = json['location'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    aboutCompany = json['about_company'];
    companyLink = json['company_link'];
  }
  String? username;
  String? email;
  String? password;
  String? userType;
  String? repeatPassword;
  dynamic cv;
  String? employmentStatus;
  String? jobName;
  String? location;
  String? companyEmail;
  String? companyPhone;
  String? aboutCompany;
  String? companyLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = userType;
    map['repeat_password'] = repeatPassword;
    map['cv'] = cv;
    map['employment_status'] = employmentStatus;
    map['job_name'] = jobName;
    map['location'] = location;
    map['company_email'] = companyEmail;
    map['company_phone'] = companyPhone;
    map['about_company'] = aboutCompany;
    map['company_link'] = companyLink;
    return map;
  }

}