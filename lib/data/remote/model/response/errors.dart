class RegisterError {
  List<String>? email;
  List<String>? nonFieldErrors;
  List<String>? userType;
  List<String>? employmentStatus;
  String? detail;

  RegisterError({
    this.email,
    this.nonFieldErrors,
    this.userType,
    this.employmentStatus,
    this.detail,
  });

  factory RegisterError.fromJson(Map<String, dynamic> json) {
    return RegisterError(
      email: json['email'] != null ? List<String>.from(json['email']) : null,
      nonFieldErrors: json['non_field_errors'] != null
          ? List<String>.from(json['non_field_errors'])
          : null,
      userType: json['user_type'] != null
          ? List<String>.from(json['user_type'])
          : null,
      employmentStatus: json['employment_status'] != null
          ? List<String>.from(json['employment_status'])
          : null,
      detail: json['detail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (nonFieldErrors != null) 'non_field_errors': nonFieldErrors,
      if (userType != null) 'user_type': userType,
      if (employmentStatus != null) 'employment_status': employmentStatus,
      if (detail != null) 'detail': detail,
    };
  }

  @override
  String toString() {
    return 'ApiError(email: $email, nonFieldErrors: $nonFieldErrors, '
        'userType: $userType , employmentStatus: $employmentStatus , detail: $detail)';
  }
}
