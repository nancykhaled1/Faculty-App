import '../../data/models/response/complaint_model.dart';
import '../../data/remote/api/complaint_remote_data_source.dart';

class SendComplaintUseCase {
  final ComplaintRemoteDataSource remoteDataSource;
  SendComplaintUseCase(this.remoteDataSource);

  Future<void> call(ComplaintModel complaint) async {
    await remoteDataSource.sendComplaint(complaint);
  }
} 