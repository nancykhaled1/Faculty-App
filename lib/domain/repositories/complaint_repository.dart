import '../../data/models/response/complaint_model.dart';

abstract class ComplaintRepository {
  Future<void> sendComplaint(ComplaintModel complaint);
} 