import '../../../../domain/entities/studentRegisterEntity.dart';

/// email : "h123@example.com"
/// username : "h12"
/// user_type : "graduation"
/// id : 3

class StudentRegisterResponse {
  StudentRegisterResponse({
      this.email, 
      this.username, 
      this.userType, 
      this.id,
  });

  StudentRegisterResponse.fromJson(dynamic json) {
    email = json['email'];
    username = json['username'];
    userType = json['user_type'];
    id = json['id'];
  }
  String? email;
  String? username;
  String? userType;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['username'] = username;
    map['user_type'] = userType;
    map['id'] = id;
    return map;
  }

  StudentRegisterResponseEntity toAuthResultEntity() {
    return StudentRegisterResponseEntity(
      email: email,
      username: username,
      userType: userType,
      id: id,
    );
  }

}

