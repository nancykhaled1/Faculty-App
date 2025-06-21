class ComplaintModel {
  final int? id;
  final String title;
  final String content;
  final String? response;
  final String? createdAt;
  final String? updatedAt;
  final String? userEmail;
  final String? userName;

  ComplaintModel({
    this.id,
    required this.title,
    required this.content,
    this.response,
    this.createdAt,
    this.updatedAt,
    this.userEmail,
    this.userName,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      response: json['response'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      //userEmail: json['user_email'],
     // userName: json['user_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
} 