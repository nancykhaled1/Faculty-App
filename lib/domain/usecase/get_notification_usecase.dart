
import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/notificationEntity.dart';
import 'package:faculty/domain/repository/repository/notification_repository_contract.dart';

import '../../data/remote/api/failures.dart';
import '../entities/departmentEntity.dart';
import '../repository/repository/dept_repository_contract.dart';

class GetNotificationUseCase{
  NotificationRepositoryContract repositoryContract;
  GetNotificationUseCase({required this.repositoryContract});
  Future<Either<Failures, List<NotificationResponseEntity>>>invoke(String token){
    return repositoryContract.getNotification(token);
  }
}