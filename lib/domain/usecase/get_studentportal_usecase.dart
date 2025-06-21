
import 'package:dartz/dartz.dart';

import '../../data/remote/api/failures.dart';
import '../entities/studentPortalEntity.dart';
import '../repository/repository/student_repository_contract.dart';

class GetStudentPortalUseCase{
  StudentRepositoryContract repositoryContract;
  GetStudentPortalUseCase({required this.repositoryContract});
  Future<Either<Failures, List<StudentPortalResponseEntity>>>invoke(){
    return repositoryContract.getStudentPortal();
  }
}