import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../data/remote/model/response/errors.dart';
import '../entities/alumniRegisterEntity.dart';
import '../entities/studentRegisterEntity.dart';
import '../repository/repository/auth_repository_contract.dart';

class RegisterUseCase{
  AuthRepositoryContract repositoryContract;
  RegisterUseCase({required this.repositoryContract});

  Future<Either<RegisterError,StudentRegisterResponseEntity>>studentInvoke( String username,
      String email,
      String password,
      String repeatPassword,
      String userType
      )
  async{
    var either = await repositoryContract.studentRegister(username, email, password, repeatPassword, userType);
    return either.fold((errorModel){
      return Left(errorModel);
    },
            (response)  {
          return Right(response);
        });
  }


  Future<Either<RegisterError,AlumniRegisterResponseEntity>> alumniInvoke(
    //  String userId,
      String username,
      String email,
      String password,
      String repeatPassword,
    //  String userType,
      dynamic cv,
      String employmentStatus,
      String jobName,
      String location,
      String companyEmail,
      String companyPhone,
      String companyLink,
      String aboutCompany,
      )
  async{
    var either = await repositoryContract.alumniRegister(username, email, password,
      repeatPassword,cv,employmentStatus,jobName,location,companyEmail,companyPhone,
        companyLink,aboutCompany
    );
    return either.fold((errorModel){
      return Left(errorModel);
    },
            (response)  {
          return Right(response);
        });
  }
}
