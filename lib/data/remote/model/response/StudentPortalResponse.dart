import '../../../../domain/entities/studentPortalEntity.dart';

/// id : 3
/// image : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/Studentportal/download_4_xvzyj3"
/// types : "الانشطه الطلابيه"
/// title : "مسابقه ال ICPC"
/// content : "شاركت كليه الحاسبات والمعلومات جامعه دمنهور في مسابقه ال ICPC"
/// link : "https://icpc.global/"
/// created_at : "2025-05-21T16:39:21.008813Z"
/// updated_at : "2025-05-21T16:39:21.008842Z"

class StudentPortalResponse extends StudentPortalResponseEntity{
  StudentPortalResponse({
      super.id,
    super.image,
    super.types,
    super.title,
    super.content,
    super.link,
    super.createdAt,
    super.updatedAt,});

  StudentPortalResponse.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    types = json['types'];
    title = json['title'];
    content = json['content'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  // int? id;
  // String? image;
  // String? types;
  // String? title;
  // String? content;
  // String? link;
  // String? createdAt;
  // String? updatedAt;



}