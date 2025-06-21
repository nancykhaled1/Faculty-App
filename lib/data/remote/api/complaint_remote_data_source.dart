import 'package:faculty/data/models/response/complaint_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComplaintRemoteDataSource {
  Future<void> sendComplaint(ComplaintModel complaint) async {
    final url = Uri.parse('https://smartcollegedmanhour-production.up.railway.app/core/complaints/create/');
    final body = jsonEncode(complaint.toJson());
    
    print('Sending to API: $url');
    print('Request body: $body');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxNTc4MTUxLCJpYXQiOjE3NTAyODIxNTEsImp0aSI6IjgyZjM4MjY3M2RlZDQ4NmY4YjU3YTgxOTZkOWFhMTI3IiwidXNlcl9pZCI6MSwidXNlcl90eXBlIjoiQ3VzdG9tVXNlciIsInVwZGF0ZVBhc3N3b3JkIjowLCJ1cGRhdGVOYW1lIjoxfQ.SD5TrxM2e1EwpY4MbV1W_mM5wdaIlysT7m44ccigJ3c', // استبدل YOUR_TOKEN_HERE بالـ token الصحيح
      },
      body: body,
    );
    
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to send complaint. Status: ${response.statusCode}, Response: ${response.body}');
    }
  }
} 