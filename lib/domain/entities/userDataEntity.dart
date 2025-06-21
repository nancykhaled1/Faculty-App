/// graduation_data : {"cv":null,"employment_status":"seeking_job","job_name":"dklbkwbkvc","location":"wsvncwlerkjnvc","company_email":"sljl@email.com","company_phone":"09389792831","company_link":"https://chatgpt.com/c/680a28b7-3130-800a-b3a0-4e52d3b4c657","about_company":"adgfewbvwetbeb","is_active":false,"user":{"id":29,"email":"qwcnzjwwx1dassl@email.com","username":"wwww"},"id":55}

class UserDataResponseEntity {
  UserDataResponseEntity({
    this.graduationData,});

  UserDataResponseEntity.fromJson(dynamic json) {
    graduationData = json['graduation_data'] != null ? GraduationDataResponseEntity.fromJson(json['graduation_data']) : null;
  }
  GraduationDataResponseEntity? graduationData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (graduationData != null) {
      map['graduation_data'] = graduationData?.toJson();
    }
    return map;
  }

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

class GraduationDataResponseEntity {
  GraduationDataResponseEntity({
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

  GraduationDataResponseEntity.fromJson(dynamic json) {
    cv = json['cv'];
    employmentStatus = json['employment_status'];
    jobName = json['job_name'];
    location = json['location'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyLink = json['company_link'];
    aboutCompany = json['about_company'];
    isActive = json['is_active'];
    user = json['user'] != null ? UserResponseEntity.fromJson(json['user']) : null;
    id = json['id'];
  }
  dynamic cv;
  String? employmentStatus;
  String? jobName;
  String? location;
  String? companyEmail;
  String? companyPhone;
  String? companyLink;
  String? aboutCompany;
  bool? isActive;
  UserResponseEntity? user;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cv'] = cv;
    map['employment_status'] = employmentStatus;
    map['job_name'] = jobName;
    map['location'] = location;
    map['company_email'] = companyEmail;
    map['company_phone'] = companyPhone;
    map['company_link'] = companyLink;
    map['about_company'] = aboutCompany;
    map['is_active'] = isActive;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['id'] = id;
    return map;
  }

}

/// id : 29
/// email : "qwcnzjwwx1dassl@email.com"
/// username : "wwww"

class UserResponseEntity {
  UserResponseEntity({
    this.id,
    this.email,
    this.username,});

  UserResponseEntity.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
  }
  int? id;
  String? email;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    return map;
  }

}