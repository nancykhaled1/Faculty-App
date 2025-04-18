import 'package:faculty/ui/auth/login/forget_pass.dart';
import 'package:faculty/ui/auth/login/re_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class SendCode extends StatefulWidget {
  static const String routeName = 'code';

  const SendCode({super.key});

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  bool isCodeComplete = false;

  void checkCodeCompletion() {
  setState(() {
  isCodeComplete = controllers.every((controller) => controller.text.isNotEmpty);
  });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.sp, left: 30.sp),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    ForgetPassScreen.routeName,
                  );
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
                    top: 30.h,
                    right: 30.w,
                    child: SvgPicture.asset(
                      'assets/images/Mail.svg', // الأيقونة الافتراضية
                      //  width: 30.sp,
                      //  height: 30.sp,
                      // color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
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

                      child: Padding(
                        padding: EdgeInsets.only(right : 15.sp , left: 15.sp, top: 50.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ارجع الي البريد الالكتروني الخاص بك!',
                                style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontSize: 20.sp,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text('تم ارسال كود مكون من 5 ارقام الي e33@gm.com قم بادخال الكود',
                                style: TextStyle(
                                  color: MyColors.greyColor,
                                  fontSize: 14.sp,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 40.h),

                              Row(
                               // textDirection: TextDirection.ltr,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    margin:  EdgeInsets.symmetric(horizontal: 7.sp),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controllers[index].text.isNotEmpty
                                            ? MyColors.primaryColor
                                            : MyColors.softGreyColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Directionality(

                                      textDirection: TextDirection.ltr,
                                      child: TextField(
                                        controller: controllers[index],
                                        focusNode: focusNodes[index],
                                        textAlign: TextAlign.center,
                                        //textDirection: TextDirection.ltr,
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            if (index < 5) {
                                              FocusScope.of(context).nextFocus(); // انتقال تلقائي للمربع التالي
                                            }
                                          } else {
                                            if (index >= 0) {
                                              FocusScope.of(context).previousFocus(); // الرجوع عند الحذف
                                            }
                                          }
                                          checkCodeCompletion(); // تحديث الـ UI بعد أي تغيير
                                        },

                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: 70.h),

                              ElevatedButton(
                                onPressed:
                                  isCodeComplete
                                      ? () {
                                    Navigator.pushNamed(
                                      context,
                                      RePassword.routeName, // عدلي هذا لاسم الشاشة التالية
                                    );
                                  }
                                      : (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isCodeComplete
                                      ? MyColors.primaryColor // لون مفعّل
                                      : MyColors.softBlueColor,
                                  foregroundColor: MyColors.whiteColor,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 105.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ), // تعطيل الزر إذا لم يكتمل الإدخال

                                child: Text(
                                  "ارسال الكود",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}
