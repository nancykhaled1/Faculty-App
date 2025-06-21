class FacultyInfoModel {
  int? id;
  String? video;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;

  FacultyInfoModel({
    this.id,
    this.video,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory FacultyInfoModel.fromJson(Map<String, dynamic> json) {
    return FacultyInfoModel(
      id: json['id'],
      video: json['video'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['video'] = video;
    data['title'] = title;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}