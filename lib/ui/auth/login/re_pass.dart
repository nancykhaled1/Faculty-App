import 'package:faculty/ui/auth/auth.dart';
import 'package:faculty/ui/auth/login/loginscreen.dart';
import 'package:faculty/ui/auth/login/send_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';

class RePassword extends StatefulWidget{
  static const String routeName = 'repass';

  @override
  State<RePassword> createState() => _RePasswordState();
}

class _RePasswordState extends State<RePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;

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
                    SendCode.routeName,
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
                    top: 18.h,
                    right: 30.w,
                    child: SvgPicture.asset(
                      'assets/images/lock.svg', // الأيقونة الافتراضية
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
                          child: Form(
                            key: formKey,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ادخال كلمة المرور الجديدة',
                                  style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 50.h),
                                buildTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  hint: 'ادخل كلمة المرور',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.sp,
                                      vertical: 20.sp,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/lock.svg', // الأيقونة الافتراضية
                                      width: 15.sp,
                                      height: 15.sp,
                                      // colorFilter: ColorFilter.mode(
                                      //   Color(0xFF7A7A7A),
                                      //   BlendMode.srcIn,
                                      // ),
                                    ),
                                  ),
                                  suffixIcon: Icon( isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                    size: 18.sp,color: MyColors.greyColor,),
                                  suffixIconFunction: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  controller: passwordController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty)
                                      return 'يرجى إدخال كلمة المرور';
                                    if (text.length < 6)
                                      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                                    return null;
                                  },
                                  label: 'كلمة المرور',
                                  isPassword: isPasswordVisible,
                                ),
                                SizedBox(height: 30.h),
                                buildTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  hint: 'ادخل تأكيد كلمة المرور',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.sp,
                                      vertical: 20.sp,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/lock.svg', // الأيقونة الافتراضية
                                      width: 15.sp,
                                      height: 15.sp,
                                      // colorFilter: ColorFilter.mode(
                                      //   Color(0xFF7A7A7A),
                                      //   BlendMode.srcIn,
                                      // ),
                                    ),
                                  ),
                                  suffixIcon: Icon( isRePasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                    size: 18.sp,color: MyColors.greyColor,),
                                  suffixIconFunction: () {
                                    setState(() {
                                      isRePasswordVisible = !isRePasswordVisible;
                                    });
                                  },
                                  controller: rePasswordController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty)
                                      return 'يرجى تأكيد كلمة المرور';
                                    if (text != passwordController.text)
                                      return 'كلمة المرور غير متطابقة';
                                    return null;
                                  },
                                  label: 'تأكيد كلمة المرور',
                                  isPassword: isRePasswordVisible,
                                ),
                                SizedBox(height: 70.h),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false, // منع الإغلاق عند الضغط خارج الـ Dialog
                                        builder: (BuildContext context) {
                                          return BuildDialog(
                                            message: "تم تعيين كلمة المرور بنجاح",
                                           // subMessage: "يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة",
                                            onDismiss: () {
                                              Navigator.pushReplacementNamed(context, AuthScreen.routeName); // الانتقال للـ login عند الإغلاق
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Text(
                                    "تعيين كلمة المرور",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.primaryColor,
                                    foregroundColor: MyColors.whiteColor,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                      horizontal: 95.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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