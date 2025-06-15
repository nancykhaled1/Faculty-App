import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/model/response/AlumniRegisterResponse.dart';
import 'package:faculty/domain/entities/LoginEntity.dart';
import 'package:faculty/domain/entities/alumniRegisterEntity.dart';
import 'package:faculty/domain/entities/userDataEntity.dart';

import '../../data/remote/api/api_manager.dart';
import '../../data/remote/model/response/errors.dart';
import '../../domain/entities/studentRegisterEntity.dart';
import '../../domain/repository/datasource/auth_remote_datasource.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource{
  ApiManager? apiManager;
  AuthRemoteDataSourceImp({required this.apiManager});
  @override
  Future<Either<RegisterError,StudentRegisterResponseEntity>> studentRegister(
      String username,
      String email,
      String password,
      String repeatPassword,
      String userType
      )
  async{
    var either = await ApiManager.studentRegister(username, email, password, repeatPassword, userType);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response.toAuthResultEntity());
        });
  }

  @override
  Future<Either<RegisterError, AlumniRegisterResponseEntity>> alumniRegister(
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
      ) async{
      var either = await ApiManager.alumniRegister(username, email, password,
          repeatPassword, cv, employmentStatus, jobName, location,
          companyEmail, companyPhone, companyLink, aboutCompany);
      return either.fold((l)  {
        return Left(l);
      },
              (response)  {
            return Right(response.toRegisterResultEntity());
          });
    }

  @override
  Future<Either<RegisterError, LoginEntity>> login(String email, String password) async {
    var either = await ApiManager.login(email, password);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response.toAuthResultEntity());
        });
  }

  @override
  Future<Either<RegisterError, UserDataResponseEntity>> fetchGraduationProfile(int id, String token) async {
    var either = await ApiManager.fetchGraduationProfile(id, token);
    return either.fold((l)  {
      return Left(l);
    },
            (response)  {
          return Right(response);
        });  }





}