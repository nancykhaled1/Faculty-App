import 'package:faculty/domain/entities/userDataEntity.dart';

/// graduation_data : {"cv":null,"employment_status":"seeking_job","job_name":"dklbkwbkvc","location":"wsvncwlerkjnvc","company_email":"sljl@email.com","company_phone":"09389792831","company_link":"https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657","about_company":"adgfewbvwetbeb","is_active":false,"user":{"id":29,"email":"qwcnzjwwx1dassl@email.com","username":"wwww"},"id":55}

class UserDataResponse extends UserDataResponseEntity{
  UserDataResponse({
      super.graduationData,});

  UserDataResponse.fromJson(dynamic json) {
    graduationData = json['graduation_data'] != null ? GraduationDataResponse.fromJson(json['graduation_data']) : null;
  }


  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   if (graduationData != null) {
  //     map['graduation_data'] = graduationData?.toJson();
  //   }
  //   return map;
  // }


}

/// cv : null
/// employment_status : "seeking_job"
/// job_name : "dklbkwbkvc"
/// location : "wsvncwlerkjnvc"
/// company_email : "sljl@email.com"
/// company_phone : "09389792831"
/// company_link : "https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657"
/// about_company : "adgfewbvwetbeb"
/// is_active : false
/// user : {"id":29,"email":"qwcnzjwwx1dassl@email.com","username":"wwww"}
/// id : 55

class GraduationDataResponse extends GraduationDataResponseEntity{
  GraduationDataResponse({
    super.cv,
    super.employmentStatus,
    super.jobName,
    super.location,
    super.companyEmail,
    super.companyPhone,
    super.companyLink,
    super.aboutCompany,
    super.isActive,
    super.user,
    super.id,});

  GraduationDataResponse.fromJson(dynamic json) {
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobName = json['job_name'];
    location = json['location'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyLink = json['company_link'];
    aboutCompany = json['about_company'];
    isActive = json['is_active'];
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    id = json['id'];
  }

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['cv'] = cv;
  //   map['employment_status'] = employmentStatus;
  //   map['job_name'] = jobName;
  //   map['location'] = location;
  //   map['company_email'] = companyEmail;
  //   map['company_phone'] = companyPhone;
  //   map['company_link'] = companyLink;
  //   map['about_company'] = aboutCompany;
  //   map['is_active'] = isActive;
  //   if (user != null) {
  //     map['user'] = user?.toJson();
  //   }
  //   map['id'] = id;
  //   return map;
  // }


}

/// id : 29
/// email : "qwcnzjwwx1dassl@email.com"
/// username : "wwww"

class UserResponse extends UserResponseEntity{
  UserResponse({
    super.id,
    super.email,
    super.username,});

  UserResponse.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
  }


  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['email'] = email;
  //   map['username'] = username;
  //   return map;
  // }








}
