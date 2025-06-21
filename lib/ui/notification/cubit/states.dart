import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/entities/notificationEntity.dart';

abstract class NotificationStates{}
class NotificationInitialStates extends NotificationStates{}
class NotificationLoadingStates extends NotificationStates{
  String? loadingMessage;
  NotificationLoadingStates({required this.loadingMessage});
}
class NotificationErrorStates extends NotificationStates{
  String? errorMessage;
  NotificationErrorStates({required this.errorMessage});
}
class NotificationSuccessStates extends NotificationStates{
//CategoryEntity categoryEntity;
  List<NotificationResponseEntity> notificationResponseEntity;
  NotificationSuccessStates({required this.notificationResponseEntity});
}
