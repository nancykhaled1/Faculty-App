import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/response/complaint_model.dart';
import '../../../domain/usecases/send_complaint_usecase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../../data/remote/api/complaint_remote_data_source.dart';

abstract class SendComplaintState {}
class SendComplaintInitial extends SendComplaintState {}
class SendComplaintLoading extends SendComplaintState {}
class SendComplaintSuccess extends SendComplaintState {}
class SendComplaintError extends SendComplaintState {
  final String message;
  SendComplaintError(this.message);
}

class SendComplaintCubit extends Cubit<SendComplaintState> {
  final SendComplaintUseCase sendComplaintUseCase;
  SendComplaintCubit(this.sendComplaintUseCase) : super(SendComplaintInitial());

  Future<void> sendComplaint(ComplaintModel complaint) async {
    emit(SendComplaintLoading());
    try {
      await sendComplaintUseCase(complaint);
      emit(SendComplaintSuccess());
    } catch (e) {
      emit(SendComplaintError(e.toString()));
    }
  }
}

Future<List<ComplaintModel>> fetchComplaints() async {
  final url = Uri.parse('https://smartcollegedmanhour-production.up.railway.app/core/complaints/');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ComplaintModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load complaints');
  }
} 