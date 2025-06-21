import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/notificationEntity.dart';
import 'package:faculty/domain/repository/datasource/notification_remote_datasource.dart';
import 'package:faculty/domain/repository/repository/notification_repository_contract.dart';

class NotificationRepositoryImp implements NotificationRepositoryContract{
  NotificationRemoteDataSource remoteDataSource;
  NotificationRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failures, List<NotificationResponseEntity>>> getNotification(String token) {
    return remoteDataSource.getNotification(token);
  }
}