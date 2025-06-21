import 'package:dartz/dartz.dart';

import '../../data/remote/model/response/errors.dart';
import '../entities/LoginEntity.dart';
import '../repository/repository/auth_repository_contract.dart';

class LoginUseCase{
  AuthRepositoryContract repositoryContract;
  LoginUseCase({required this.repositoryContract});

  Future<Either<RegisterError,LoginEntity>>invoke(String email , String password )
  async{
    var either = await repositoryContract.login(email, password);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response);
        });
  }
}