import 'package:faculty/ui/auth/auth_alumni.dart';
import 'package:faculty/ui/auth/login/loginscreen.dart';
import 'package:faculty/ui/auth/login/send_code.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/text_field.dart';

class ForgetPassScreen extends StatelessWidget{
  static const String routeName = 'pass';
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.sp, right: 30.sp),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, AlumniAuthScreen.routeName);
              },
              child: SvgPicture.asset(
                'assets/icons/upload.svg', // الأيقونة الافتراضية
                width: 30.sp,
                height: 30.sp,
                // color: Colors.black,
              ),
            ),
          ),
        //  SizedBox(height: 35.h),
          Center(
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/background-simple.svg', // الأيقونة الافتراضية
                 // width: 30.sp,
                 // height: 30.sp,
                  // color: Colors.black,
                ),
                Positioned(
                  top: 15.h,
                  right: 35.w,
                  child: SvgPicture.asset(
                    'assets/images/logo2.svg', // الأيقونة الافتراضية
                  //  width: 30.sp,
                  //  height: 30.sp,
                    // color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
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
                    child: Padding(
                      padding: EdgeInsets.only(right : 15.sp , left: 15.sp, top: 50.sp),
                      child: SingleChildScrollView(
                        child: Column(
                         // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontFamily: "Noto Kufi Arabic",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400
                            ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'قم بادخال بريدك الالكتروني لارسال عليه كود\nالتحقق',
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontSize: 14.sp,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w400
                            ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: buildTextField(
                                keyboardType: TextInputType.emailAddress,
                                hint: 'ادخل بريدك الالكتروني',
                                prefixIcon: Padding(
                                  padding:  EdgeInsets.only(top: 14.sp,left: 6.sp,right: 6.sp,bottom: 4.sp),
                                  child: SvgPicture.asset(
                                    'assets/icons/mail.svg', // الأيقونة الافتراضية
                                    width: 15.sp,
                                    height: 15.sp,
                                    colorFilter: ColorFilter.mode(
                                      MyColors.greyColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                controller: emailController,
                                validator: (text) {
                                  if (text!.isEmpty ||
                                      text.trim().isEmpty) {
                                    return 'برجاء ادخال البريد الالكترونى';
                                  }
                                  bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text);
                                  if (!emailValid) {
                                    return 'برجاء ادخال بريد الكتروني صحيح';
                                  }
                                  return null;
                                },
                                label: 'البريد الالكتروني',
                              ),
                            ),
                        
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding:  EdgeInsets.all(8.sp),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, SendCode.routeName);
                                },
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primaryColor,
                                  foregroundColor: MyColors.whiteColor,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 90.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                    ),


                  ),
                ),
              ],
            ),
          ),
        ],
      )
    )
    );
  }

}