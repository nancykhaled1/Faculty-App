import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/repository/datasource/dept_remote_datasource.dart';

import '../../domain/repository/repository/dept_repository_contract.dart';

class DepartmentRepositoryImp implements DepartmentRepositoryContract{
  DepartmentRemoteDataSource remoteDataSource;
  DepartmentRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<DepartmentResponseEntity>>> getAllDepartment() {
    return remoteDataSource.getAllDepartment();
  }


}