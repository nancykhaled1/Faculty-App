import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import '../../data/remote/model/request/updatedataRequest.dart';
import '../entities/updateDataEntity.dart';
import '../repository/repository/updatedata_repository_contract.dart';

class UpdateDataUseCase{
  UpdateDataRepositoryContract repositoryContract;
  UpdateDataUseCase({required this.repositoryContract});

  Future<Either<Failures,UpdataDataResponseEntity>>invoke(String token, UpdateDataRequest request, )
  async{
    var either = await repositoryContract.updateData(token , request);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response);
        });
  }
}