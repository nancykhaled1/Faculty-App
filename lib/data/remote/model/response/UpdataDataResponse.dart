import 'package:faculty/domain/entities/updateDataEntity.dart';

/// message : "Graduation data updated successfully."
/// graduation_data : {"cv":null,"employment_status":"seeking_job","job_name":"dklbkwbkvc","location":"ghhhhhhh","company_email":"sljl@email.com","company_phone":"09389792831","company_link":"https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657","about_company":"adgfewbvwetbeb","is_active":false,"user":{"id":39,"email":"nancy8@yahoo.com","username":"wwww"},"id":33}

class UpdataDataResponse extends UpdataDataResponseEntity {
  UpdataDataResponse({
    super.message,
    super.graduationData,});

  UpdataDataResponse.fromJson(dynamic json) {
    message = json['message'];
    graduationData = json['graduation_data'] != null ? UpdateGraduationData.fromJson(json['graduation_data']) : null;
  }
  // String? message;
  // UpdateGraduationData? graduationData;



}

/// cv : null
/// employment_status : "seeking_job"
/// job_name : "dklbkwbkvc"
/// location : "ghhhhhhh"
/// company_email : "sljl@email.com"
/// company_phone : "09389792831"
/// company_link : "https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657"
/// about_company : "adgfewbvwetbeb"
/// is_active : false
/// user : {"id":39,"email":"nancy8@yahoo.com","username":"wwww"}
/// id : 33

class UpdateGraduationData extends UpdateGraduationDataEntity {
  UpdateGraduationData({
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

  UpdateGraduationData.fromJson(dynamic json) {
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobName = json['job_name'];
    location = json['location'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyLink = json['company_link'];
    aboutCompany = json['about_company'];
    isActive = json['is_active'];
    user = json['user'] != null ? UpdateUserData.fromJson(json['user']) : null;
    id = json['id'];
  }
  // dynamic cv;
  // String? employmentStatus;
  // String? jobName;
  // String? location;
  // String? companyEmail;
  // String? companyPhone;
  // String? companyLink;
  // String? aboutCompany;
  // bool? isActive;
  // UpdateUserData? user;
  // int? id;



}

/// id : 39
/// email : "nancy8@yahoo.com"
/// username : "wwww"

class UpdateUserData extends UpdateUserDataEntity{
  UpdateUserData({
      super.id,
      super.email,
      super.username,});

  UpdateUserData.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
  }




}