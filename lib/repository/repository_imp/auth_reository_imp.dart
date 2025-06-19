import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/LoginEntity.dart';
import 'package:faculty/domain/entities/alumniRegisterEntity.dart';
import 'package:faculty/domain/entities/userDataEntity.dart';
import '../../data/remote/model/response/errors.dart';
import '../../domain/entities/studentRegisterEntity.dart';
import '../../domain/repository/datasource/auth_remote_datasource.dart';
import '../../domain/repository/repository/auth_repository_contract.dart';

class AuthRepositoryImp implements AuthRepositoryContract{
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImp({required this.remoteDataSource});


  @override
  Future<Either<RegisterError, StudentRegisterResponseEntity>> studentRegister(
      String username, String email, String password, String repeatPassword , String userType) {
    return remoteDataSource.studentRegister(username, email, password, repeatPassword, userType);
  }

  @override
  Future<Either<RegisterError, AlumniRegisterResponseEntity>> alumniRegister(String username,
      String email, String password, String repeatPassword,  dynamic cv, String employmentStatus, String jobName, String location, String companyEmail, String companyPhone, String companyLink, String aboutCompany) {
    return remoteDataSource.alumniRegister(username, email, password, repeatPassword, cv, employmentStatus, jobName, location, companyEmail, companyPhone, companyLink, aboutCompany);
  }

  @override
  Future<Either<RegisterError, LoginEntity>> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<Either<RegisterError, UserDataResponseEntity>> fetchGraduationProfile(String token) {
    return remoteDataSource.fetchGraduationProfile(token);
  }






}