import 'package:dartz/dartz.dart';
import 'package:faculty/domain/entities/updateDataEntity.dart';

import '../../../data/remote/api/failures.dart';
import '../../../data/remote/model/request/updatedataRequest.dart';

abstract class UpdateDataDatasource{
  Future<Either<Failures,UpdataDataResponseEntity>>updateData(String token , UpdateDataRequest request,);


}