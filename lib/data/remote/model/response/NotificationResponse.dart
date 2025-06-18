import 'package:faculty/domain/entities/notificationEntity.dart';

/// id : 2
/// title : "إعلان عام"
/// body : "المعرض الوظيفي يوم الأحد"
/// created_at : "2025-06-17T21:27:02.219808Z"
/// receiver : null
/// receiver_info : null
/// send_to_all : true

class NotificationResponse extends NotificationResponseEntity{
  NotificationResponse({
      super.id,
    super.title,
    super.body,
    super.createdAt,
    super.receiver,
    super.receiverInfo,
    super.sendToAll,
    super.message,
  });

  NotificationResponse.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    receiver = json['receiver'];
    receiverInfo = json['receiver_info'];
    sendToAll = json['send_to_all'];
    message = json['message'];

  }




}