class UpdateDataRequest {
  final String username;
  final String email;
  final String employmentStatus;
  final String? jobName;
  final String? companyEmail;
  final String? companyPhone;
  final String? companyLink;
  final String? aboutCompany;
  final String? location;
  final String? cv;

  UpdateDataRequest({
    required this.username,
    required this.email,
    required this.employmentStatus,
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
      'email': email,
      'employment_status': employmentStatus,
      'jobName': jobName,
      'companyEmail': companyEmail,
      'companyPhone': companyPhone,
      'companyLink': companyLink,
      'aboutCompany': aboutCompany,
      'location': location,
      'cv': cv,
    };

    // احذف المفاتيح اللي قيمتها null
    data.removeWhere((key, value) => value == null);

    return data;
  }

}
