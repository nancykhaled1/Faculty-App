import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/studentRegisterEntity.dart';
import 'package:faculty/domain/repository/datasource/student_remote_datasource.dart';
import '../../data/remote/api/api_manager.dart';
import '../../data/remote/api/failures.dart';
import '../../domain/entities/studentEntity.dart';
import '../../domain/entities/studentPortalEntity.dart';

class StudentDataSourceImp implements StudentRemoteDataSource{
  ApiManager? apiManager;
  StudentDataSourceImp({required this.apiManager});
  @override
  Future<Either<Failures, List<StudentResponseEntity>>> getStudentService() async {
    var either = await ApiManager.getStudentService();
    return either.fold((error) {
      return Left(Failures(errorMessage: error.errorMessage));
    },
            (response) {
          return Right(response);
        }
    );
  }

  @override
  Future<Either<Failures, List<StudentPortalResponseEntity>>> getStudentPortal() async {
    var either = await ApiManager.getStudentPortal();
    return either.fold((error) {
      return Left(Failures(errorMessage: error.errorMessage));
    },
            (response) {
          return Right(response);
        }
    );
  }

}