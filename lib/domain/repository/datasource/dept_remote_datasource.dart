import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/departmentEntity.dart';

import '../../../data/remote/api/failures.dart';

abstract class DepartmentRemoteDataSource{
  Future<Either<Failures,List<DepartmentResponseEntity>>>getAllDepartment();

}