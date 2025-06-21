// class UpdateDataRequest {
//   final String username;
//   final String email;
//   final String employmentStatus;
//   final String? jobName;
//   final String? companyEmail;
//   final String? companyPhone;
//   final String? companyLink;
//   final String? aboutCompany;
//   final String? location;
//   final String? cv;
//
//   UpdateDataRequest({
//     required this.username,
//     required this.email,
//     required this.employmentStatus,
//     this.jobName,
//     this.companyEmail,
//     this.companyPhone,
//     this.companyLink,
//     this.aboutCompany,
//     this.location,
//     this.cv,
//   });
//
//   Map<String, dynamic> toJson() {
//     final data = {
//       'username': username,
//       'email': email,
//       'employment_status': employmentStatus,
//       'jobName': jobName,
//       'companyEmail': companyEmail,
//       'companyPhone': companyPhone,
//       'companyLink': companyLink,
//       'aboutCompany': aboutCompany,
//       'location': location,
//       'cv': cv,
//     };
//
//     // احذف المفاتيح اللي قيمتها null
//     data.removeWhere((key, value) => value == null);
//
//     return data;
//   }
//
// }
class UpdateDataRequest {
  final String username;
  final String employmentStatus;
  final String? email;
  final String? jobName;
  final String? companyEmail;
  final String? companyPhone;
  final String? companyLink;
  final String? aboutCompany;
  final String? location;
  final String? cv;

  UpdateDataRequest({
    required this.username,
    required this.employmentStatus,
    this.email,
    this.jobName,
    this.companyEmail,
    this.companyPhone,
    this.companyLink,
    this.aboutCompany,
    this.location,
    this.cv,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'username': username,
      'employment_status': employmentStatus,
      'email': email,
      'job_name': jobName,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_link': companyLink,
      'about_company': aboutCompany,
      'location': location,
      'cv': cv,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

