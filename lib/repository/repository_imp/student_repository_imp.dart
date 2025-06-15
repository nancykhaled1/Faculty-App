import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/studentEntity.dart';
import 'package:faculty/domain/entities/studentPortalEntity.dart';
import 'package:faculty/domain/repository/datasource/student_remote_datasource.dart';
import 'package:faculty/domain/repository/repository/student_repository_contract.dart';

class StudentRepositoryImp implements StudentRepositoryContract {
  StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<StudentResponseEntity>>> getStudentService() {
    return remoteDataSource.getStudentService();
  }

  @override
  Future<Either<Failures, List<StudentPortalResponseEntity>>> getStudentPortal() {
    return remoteDataSource.getStudentPortal();
  }
}

