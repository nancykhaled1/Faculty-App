import 'package:dartz/dartz.dart';

import '../../data/remote/api/failures.dart';
import '../entities/studentEntity.dart';
import '../repository/repository/dept_repository_contract.dart';
import '../repository/repository/student_repository_contract.dart';

class GetStudentServiceUseCase{
  StudentRepositoryContract repositoryContract;
  GetStudentServiceUseCase({required this.repositoryContract});
  Future<Either<Failures, List<StudentResponseEntity>>>invoke(){
    return repositoryContract.getStudentService();
  }
}