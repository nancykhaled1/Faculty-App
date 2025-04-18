
import 'package:faculty/colorManager.dart';
import 'package:faculty/complaint/ComplaintDetailsPage.dart';
import 'package:faculty/complaint/complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Inquriescomplaint extends StatefulWidget {
  const Inquriescomplaint({super.key});

  @override
  State<Inquriescomplaint> createState() => _InquriescomplainState();
}

class _InquriescomplainState extends State<Inquriescomplaint> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:45,right:5),
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
                  child: Transform(
                      transform: Matrix4.identity()..scale(-1.0, 1.0), 
                    child: SvgPicture.asset(
                      "assets/images/Upload.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ),
              ],
            ),
              SizedBox(height: 40.h), 




               
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Container(
                  width:343.w,
                  height: 95.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                     boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // لون الظل
                        spreadRadius: 2,   // مدى انتشار الظل
                        blurRadius: 6,     // نعومة الظل
                        offset: Offset(0, 3), // مكانه (أفقي, عمودي)
                      ),
                    ],
                    color: ColorManager.backgroundColor,
                  ),
                 child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        Padding(
                          padding: const EdgeInsets.only(right:16,top:15,bottom: 15),
                          child: Column(
                           // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                Text("اسم الشكوى",
                textAlign: TextAlign.right,
                
                style: TextStyle(
                  
                fontFamily: "Noto Kufi Arabic",
                fontSize: 16.sp,
                 fontWeight: FontWeight.w400,
                ),
                ),
                SizedBox(height: 20.h,),
                 Text(".....انا لدي مشكلة في",style: TextStyle(
                fontFamily: "Noto Kufi Arabic",color:ColorManager.hintText,
                fontSize: 12.sp,
                 fontWeight: FontWeight.w400,
                ),
                ),
                
                            ],
                            
                          
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: SvgPicture.asset("assets/icons/wait.svg",
                          width: 51.w,
                          height: 40.h,),
                        ),
                
                      ],
                    )
                  ],
                 ),
                ),
              )
              ,

              SizedBox(height: 30.h,)   ,
Padding(
  padding: const EdgeInsets.only(left: 25, right: 25),
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Complaintdetailspage()), // ✅ غيّري الصفحة هنا حسب اللي عايزاه
      );
    },
    child: Container(
      width: 343.w,
      height: 95.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // لون الظل
            spreadRadius: 2,   // مدى انتشار الظل
            blurRadius: 6,     // نعومة الظل
            offset: Offset(0, 3), // مكانه (أفقي, عمودي)
          ),
        ],
        color: ColorManager.backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      "اسم الشكوى",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      ".....انا لدي مشكلة في",
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        color: ColorManager.hintText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  "assets/icons/accept.svg",
                  width: 51.w,
                  height: 34.h,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ),
),

            







              

       ] )));       
              
                  
          
        
  }
}