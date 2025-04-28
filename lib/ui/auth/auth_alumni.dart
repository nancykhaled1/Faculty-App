import 'package:faculty/ui/auth/register/student_register.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login/loginscreen.dart';
import 'register/alumniregisterscreen.dart';

class AlumniAuthScreen extends StatefulWidget {
  static const String routeName = 'auth';

  @override
  State<AlumniAuthScreen> createState() => _AlumniAuthScreenState();
}

class _AlumniAuthScreenState extends State<AlumniAuthScreen> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/log.png',
                //  height: 150, // تأكد من أن الصورة ليست كبيرة جدًا
                ),
              ),
              SizedBox(height: 10.h),
              // شريط التنقل بين "تسجيل الدخول" و "إنشاء حساب"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = true; 
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w500,
                            color:
                            isLogin ? MyColors.primaryColor : MyColors.greyColor,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        if (isLogin)  
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Container(width: 1, height: 25, color: MyColors.greyColor),
                  SizedBox(width: 15.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = false;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w500,
                            color:
                            !isLogin ? MyColors.primaryColor : MyColors.greyColor,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        if (!isLogin)
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // الـ Stack اللي يحتوي على الشريط الأزرق والكونتينر الأبيض
              Expanded(
                child: Stack(
                  children: [
                    // الـ Container العلوي الملون (الشريط)
                    Container(
                      // height: 120, // ارتفاع الشريط العلوي
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [MyColors.primaryColor, MyColors.secondryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35.r),
                      ),
                    ),

                    // الكونتينر الأبيض الذي يمتد لباقي الشاشة
                    Positioned(
                      top: 6, // رفع الكونتينر الأبيض لأعلى قليلًا
                      left: 0,
                      right: 0,
                      bottom: 0, // عشان يغطي باقي الشاشة
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.r),
                            topRight: Radius.circular(35.r),
                          ),
                        ),

                        //هنا لو اليزر اختار منصه الخريجين  لكن لو اختار الشكاوى هيبقى اللوجين و الطالب
                       // child: isLogin ? LoginScreen() : StudentRegister(),
                        child: isLogin ? LoginScreen() : AlumniRegisterScreen(),


                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


