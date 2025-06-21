import 'package:faculty/data/models/response/complaint_model.dart';
import 'package:faculty/utils/colorManager.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faculty/ui/complaint/cubit/send_complaint_cubit.dart';
import 'package:faculty/domain/usecases/send_complaint_usecase.dart';
import 'package:faculty/data/remote/api/complaint_remote_data_source.dart';

import 'inquiriesComplaint.dart';
import 'sendComplaint.dart';

class Complaintdetailspage extends StatefulWidget {
  final ComplaintModel complaint;

  const Complaintdetailspage({super.key, required this.complaint});

  @override
  State<Complaintdetailspage> createState() => _ComplaintdetailspageState();
}

class _ComplaintdetailspageState extends State<Complaintdetailspage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(  
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 الصف في الأعلى
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                  
                // ---> صندوق عرض عنوان الشكوى <---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 60.h,
        maxHeight: 200.h, // لو الرد طويل هيتسكرل
      ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: 343.w,
                     //  height: 92.h,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                          topRight: Radius.circular(20.r),  // ✅ ريديوس
                          topLeft: Radius.circular(20.r),   // ✅ ريديوس
                          bottomLeft: Radius.circular(20.r), // ✅ ريديوس
                          bottomRight: Radius.zero,  
                          ),
                        border: Border.all(
                          color: ColorManager.textColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          SizedBox(height: 8.h),
                          SingleChildScrollView(
                            child: Text(
                              widget.complaint.title,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "Noto Kufi Arabic",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                           SingleChildScrollView(
                             child: Text(
                              widget.complaint.content, 
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "Noto Kufi Arabic",
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700
                              ),
                                                       ),
                           ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                     ),     SizedBox(height: 20.h),
            
                // ---> صندوق عرض رد الإدمن (يظهر فقط عند وجود رد) <---
                if (widget.complaint.response != null && widget.complaint.response!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 343.w,
                     // height: 90.h,
                    
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),  // ✅ ريديوس
                        topLeft: Radius.circular(20.r),   // ✅ ريديوس
                        bottomLeft: Radius.zero, // ✅ ريديوس
                        bottomRight: Radius.circular(20.r),       // ❌ بدون ريديوس
                      ),
                        border: Border.all(
                          
                          color: Color(0XFF84DA4F), // لون الرد
                          width: 1,
                        ), 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         
                          SizedBox(height: 8.h),
                          Container(
                             constraints: BoxConstraints(
                           // minHeight: 90.h,
                    maxHeight: 200.h, // أو أي ارتفاع يناسب
                ),
                            child: SingleChildScrollView(
                              child: Text(
                               
                                widget.complaint.response!,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}