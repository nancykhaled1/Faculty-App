import 'package:dartz/dartz.dart';

import '../../data/remote/model/response/errors.dart';
import '../entities/LoginEntity.dart';
import '../entities/userDataEntity.dart';
import '../repository/repository/auth_repository_contract.dart';

class GetUserdataUseCase{
  AuthRepositoryContract repositoryContract;
  GetUserdataUseCase({required this.repositoryContract});

  Future<Either<RegisterError,UserDataResponseEntity>>invoke(int id , String token )
  async{
    var either = await repositoryContract.fetchGraduationProfile(id, token);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response);
        });
  }
}