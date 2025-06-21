import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/updateDataEntity.dart';
import 'package:faculty/domain/repository/repository/updatedata_repository_contract.dart';

import '../../data/remote/model/request/updatedataRequest.dart';
import '../../domain/repository/datasource/update_data_datasource.dart';

class UpdateDataRepositoryImp implements UpdateDataRepositoryContract{
  UpdateDataDatasource remoteDataSource;
  UpdateDataRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failures, UpdataDataResponseEntity>> updateData(String token , UpdateDataRequest request,) {
    return remoteDataSource.updateData(token , request);
  }
}