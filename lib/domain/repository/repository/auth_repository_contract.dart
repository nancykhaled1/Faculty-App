import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/alumniRegisterEntity.dart';
import '../../../data/remote/model/response/errors.dart';
import '../../entities/LoginEntity.dart';
import '../../entities/studentRegisterEntity.dart';
import '../../entities/userDataEntity.dart';

abstract class AuthRepositoryContract{
  Future<Either<RegisterError,StudentRegisterResponseEntity>> studentRegister( String username,
      String email,
      String password,
      String repeatPassword,
      String userType
      );


  Future<Either<RegisterError,AlumniRegisterResponseEntity>> alumniRegister(
     // String userId,
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
      );



  Future<Either<RegisterError,LoginEntity>> login(String email , String password);
  Future<Either<RegisterError,UserDataResponseEntity>> fetchGraduationProfile(String token);


}

