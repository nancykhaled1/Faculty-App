import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/updateDataEntity.dart';
import 'package:faculty/domain/repository/datasource/update_data_datasource.dart';

import '../../data/remote/api/api_manager.dart';
import '../../data/remote/model/request/updatedataRequest.dart';

class UpdateDataRemoteDatasourceImp implements UpdateDataDatasource{
  ApiManager? apiManager;
  UpdateDataRemoteDatasourceImp({required this.apiManager});
  @override
  Future<Either<Failures, UpdataDataResponseEntity>> updateData(String token,UpdateDataRequest request,) async {
    var either = await ApiManager.updateData(token, request);
    return either.fold((error) {
      return Left(Failures(errorMessage: error.errorMessage));
    },
            (response) {
          return Right(response);
        }
    );
  }





}