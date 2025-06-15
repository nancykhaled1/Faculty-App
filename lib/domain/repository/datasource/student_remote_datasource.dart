import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/studentEntity.dart';

import '../../../data/remote/api/failures.dart';
import '../../entities/studentPortalEntity.dart';

abstract class StudentRemoteDataSource{
  Future<Either<Failures,List<StudentResponseEntity>>>getStudentService();
  Future<Either<Failures,List<StudentPortalResponseEntity>>>getStudentPortal();


}