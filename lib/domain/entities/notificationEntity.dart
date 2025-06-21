
/// id : 2
/// title : "إعلان عام"
/// body : "المعرض الوظيفي يوم الأحد"
/// created_at : "2025-06-17T21:27:02.219808Z"
/// receiver : null
/// receiver_info : null
/// send_to_all : true

class NotificationResponseEntity{
  NotificationResponseEntity({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.receiver,
    this.receiverInfo,
    this.sendToAll,
  this.message});


  int? id;
  String? title;
  String? body;
  String? createdAt;
  dynamic receiver;
  dynamic receiverInfo;
  bool? sendToAll;
  String? message;



}