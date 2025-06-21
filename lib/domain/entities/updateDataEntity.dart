/// message : "Graduation data updated successfully."
/// graduation_data : {"cv":null,"employment_status":"seeking_job","job_name":"dklbkwbkvc","location":"ghhhhhhh","company_email":"sljl@email.com","company_phone":"09389792831","company_link":"https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657","about_company":"adgfewbvwetbeb","is_active":false,"user":{"id":39,"email":"nancy8@yahoo.com","username":"wwww"},"id":33}

class UpdataDataResponseEntity {
  UpdataDataResponseEntity({
    this.message,
    this.graduationData,});

  String? message;
  UpdateGraduationDataEntity? graduationData;


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

class UpdateGraduationDataEntity {
  UpdateGraduationDataEntity({
    this.cv,
    this.employmentStatus,
    this.jobName,
    this.location,
    this.companyEmail,
    this.companyPhone,
    this.companyLink,
    this.aboutCompany,
    this.isActive,
    this.user,
    this.id,});


  dynamic cv;
  String? employmentStatus;
  String? jobName;
  String? location;
  String? companyEmail;
  String? companyPhone;
  String? companyLink;
  String? aboutCompany;
  bool? isActive;
  UpdateUserDataEntity? user;
  int? id;



}

/// id : 39
/// email : "nancy8@yahoo.com"
/// username : "wwww"

class UpdateUserDataEntity {
  UpdateUserDataEntity({
    this.id,
    this.email,
    this.username,});


  int? id;
  String? email;
  String? username;



}