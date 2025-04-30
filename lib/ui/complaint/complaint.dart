import 'package:faculty/colorManager.dart';
import 'package:faculty/ui/complaint/sendComplaint.dart';
import 'package:faculty/ui/home.dart';
import 'package:faculty/ui/home/homescreen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'inquiriesComplaint.dart';

class Complaint extends StatelessWidget {
  static const String routeName = 'Complaint';
  const Complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top:10.h,right:10.w),
          child: SingleChildScrollView(
            child: Center(
              child: Column( // 🔹 Column رئيسي لترتيب العناصر عموديًا
                crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر لليمين
                children: [
                  // 🔹 الصف في الأعلى
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // جعل العناصر في نهاية الصف (يمين)
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/icons/backarrow.svg", // استبدل باسم ملفك
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 20.h), // مسافة بين الـ Row والـ Column الذي تحته
            
                  // 🔹 العمود الذي يحتوي على عناصر أخرى
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 73,right: 74),
                        child: Text(
                          " منصة الشكاوي والأراء   ",
                          style: TextStyle(fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Noto Kufi Arabic",
                            color:ColorManager.primaryColor0,),
                        ),
                      ),
            
                      SizedBox(height: 24.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 22,right: 23),
                        child: Text(
                          " لا تتردد في كتابة رأيك فنحن بانتظاره  ",
                          style: TextStyle(fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Noto Kufi Arabic",
                            color:ColorManager.hintText,),
                        ),
                      ),
            
                      SizedBox(height: 92.h),
            
            
                      Padding(
                        padding: const EdgeInsets.only(right: 23,left: 22),
                        child: Container(
                          width:348.w,
                          height: 106.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            //color: Color(0xffEF8D32),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Inquriescomplaint()), // ✅ استبدلي الصفحة باللي عايزاها
                              );
                            },
            
            
                            child: Center(
                              child: SvgPicture.asset("assets/images/inquiresComplaint.svg",
                                width: 348.w,
                                height: 106.h,
                                // fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                      ),
            
            
            
                      SizedBox(height: 72.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 23,left: 22),
                        child: Center(
                          child: Container(
                            width: 348.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: ColorManager.primaryColor0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SendComplaint()), // ✅ استبدلي الصفحة باللي عايزاها
                                );
                              },
            
                              child: SvgPicture.asset("assets/images/sendcomplaintt.svg",
                                width: 348.w,
                                height: 106.h,
                                // fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
            
            
            
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}