import 'package:dartz/dartz.dart';

import '../../../data/remote/api/failures.dart';
import '../../entities/departmentEntity.dart';

abstract class DepartmentRepositoryContract{
Future<Either<Failures,List<DepartmentResponseEntity>>>getAllDepartment();

}