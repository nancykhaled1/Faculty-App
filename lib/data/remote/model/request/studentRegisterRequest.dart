/// username : "h12"
/// email : "h124@example.com"
/// password : "123"
/// user_type : "graduation"
/// repeat_password : "123"

class StudentRegisterRequest {
  StudentRegisterRequest({
      this.username, 
      this.email, 
      this.password, 
      this.userType, 
      this.repeatPassword,});

  StudentRegisterRequest.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    userType = json['user_type'];
    repeatPassword = json['repeat_password'];
  }
  String? username;
  String? email;
  String? password;
  String? userType;
  String? repeatPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = userType;
    map['repeat_password'] = repeatPassword;
    return map;
  }

}