import 'package:dartz/dartz.dart';

import '../../../data/remote/api/failures.dart';
import '../../../data/remote/model/request/updatedataRequest.dart';
import '../../entities/updateDataEntity.dart';

abstract class UpdateDataRepositoryContract{
  Future<Either<Failures,UpdataDataResponseEntity>>updateData(String token , UpdateDataRequest request,);


}