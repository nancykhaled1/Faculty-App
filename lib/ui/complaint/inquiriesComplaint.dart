import 'package:faculty/utils/colorManager.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ComplaintDetailsPage.dart';
import 'complaint.dart';
import '../../data/models/response/complaint_model.dart';
import '../complaint/cubit/send_complaint_cubit.dart';

class Inquriescomplaint extends StatefulWidget {
  const Inquriescomplaint({super.key});

  @override
  State<Inquriescomplaint> createState() => _InquriescomplainState();
}

class _InquriescomplainState extends State<Inquriescomplaint> {

  late Future<List<ComplaintModel>> complaintsFuture;

  Future<List<ComplaintModel>> fetchComplaints() async {
    final url = Uri.parse('https://smartcollegedmanhour-production.up.railway.app/core/complaints/');
    
    print('Fetching complaints from: $url');
    
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxNTc4MTUxLCJpYXQiOjE3NTAyODIxNTEsImp0aSI6IjgyZjM4MjY3M2RlZDQ4NmY4YjU3YTgxOTZkOWFhMTI3IiwidXNlcl9pZCI6MSwidXNlcl90eXBlIjoiQ3VzdG9tVXNlciIsInVwZGF0ZVBhc3N3b3JkIjowLCJ1cGRhdGVOYW1lIjoxfQ.SD5TrxM2e1EwpY4MbV1W_mM5wdaIlysT7m44ccigJ3c',
      },
    );
    
    print('GET Response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      print('GET Response body (decoded): $decodedBody');
      final List<dynamic> data = jsonDecode(decodedBody);
      print('Found ${data.length} complaints');
      return data.map((json) {
        print('Parsing complaint: $json');
        return ComplaintModel.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load complaints. Status: ${response.statusCode}, Response: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    complaintsFuture = fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 الصف في الأعلى
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Complaint()),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/icons/backarrow.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: FutureBuilder<List<ComplaintModel>>(
                  future: complaintsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('حدث خطأ أثناء تحميل الشكاوى'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('لا توجد شكاوى'));
                    }
                    final complaints = snapshot.data!;
                    return ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];
                        final bool hasResponse = complaint.response != null && complaint.response!.isNotEmpty;
                        
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Complaintdetailspage(complaint: complaint),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 16.h),
                            child: Container(
                              width: 343.w,
                              height: 95.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.colorgrey.withOpacity(.2),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: ColorManager.backgroundColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 16,
                                        top: 16,
                                        bottom: 16,
                                      ),   
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:10),
                                            child: Text(
                                              complaint.title,
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: "Noto Kufi Arabic",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: Text(
                                              complaint.content,
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: "Noto Kufi Arabic",
                                                color: ColorManager.hintText,
                                                fontSize: 14.sp,
                                                                        fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: SvgPicture.asset(
                                      hasResponse 
                                        ? "assets/icons/accept.svg" 
                                        : "assets/icons/wait.svg",
                                      width: 40.w,
                                      height: 40.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
