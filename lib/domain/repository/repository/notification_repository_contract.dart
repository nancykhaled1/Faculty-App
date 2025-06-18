
import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import '../../entities/notificationEntity.dart';


abstract class NotificationRepositoryContract{
  Future<Either<Failures,List<NotificationResponseEntity>>> getNotification(String token);
}
