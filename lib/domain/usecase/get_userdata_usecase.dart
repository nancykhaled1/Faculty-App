import 'package:dartz/dartz.dart';

import '../../data/remote/model/response/errors.dart';
import '../entities/LoginEntity.dart';
import '../entities/userDataEntity.dart';
import '../repository/repository/auth_repository_contract.dart';

class GetUserdataUseCase{
  AuthRepositoryContract repositoryContract;
  GetUserdataUseCase({required this.repositoryContract});

  Future<Either<RegisterError,UserDataResponseEntity>>invoke(String token )
  async{
    var either = await repositoryContract.fetchGraduationProfile(token);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response);
        });
  }
}