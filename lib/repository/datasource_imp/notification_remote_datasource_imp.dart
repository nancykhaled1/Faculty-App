import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/entities/notificationEntity.dart';
import 'package:faculty/domain/repository/datasource/dept_remote_datasource.dart';
import 'package:faculty/domain/repository/datasource/notification_remote_datasource.dart';

import '../../data/remote/api/api_manager.dart';

class NotificationDataSourceImp implements NotificationRemoteDataSource{
  ApiManager? apiManager;
  NotificationDataSourceImp({required this.apiManager});
  @override
  Future<Either<Failures, List<NotificationResponseEntity>>> getNotification(String token) async {
    var either = await ApiManager.getNotification(token);
    return either.fold((error) {
      return Left(Failures(errorMessage: error.errorMessage));
    },
            (response) {
          return Right(response);
        }
    );
  }





}