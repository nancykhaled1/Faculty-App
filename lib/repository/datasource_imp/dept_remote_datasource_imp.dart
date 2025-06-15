import 'package:dartz/dartz.dart';
import 'package:faculty/data/remote/api/failures.dart';
import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/repository/datasource/dept_remote_datasource.dart';

import '../../data/remote/api/api_manager.dart';

class DepartmentDataSourceImp implements DepartmentRemoteDataSource{
  ApiManager? apiManager;
  DepartmentDataSourceImp({required this.apiManager});
  @override
  Future<Either<Failures, List<DepartmentResponseEntity>>> getAllDepartment() async {
    var either = await ApiManager.getDepartment();
    return either.fold((error) {
      return Left(Failures(errorMessage: error.errorMessage));
    },
            (response) {
          return Right(response);
        }
    );
  }

}