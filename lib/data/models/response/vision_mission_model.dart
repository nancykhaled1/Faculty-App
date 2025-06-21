class VisionMissionModel {
  int? id;
  String? image;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;

  VisionMissionModel(
      {this.id,
      this.image,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt});

  VisionMissionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}