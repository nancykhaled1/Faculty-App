
import 'package:dartz/dartz.dart';

import '../../data/remote/api/failures.dart';
import '../entities/departmentEntity.dart';
import '../repository/repository/dept_repository_contract.dart';

class GetAllDepartmentUseCase{
  DepartmentRepositoryContract repositoryContract;
  GetAllDepartmentUseCase({required this.repositoryContract});
  Future<Either<Failures, List<DepartmentResponseEntity>>>invoke(){
    return repositoryContract.getAllDepartment();
  }
}