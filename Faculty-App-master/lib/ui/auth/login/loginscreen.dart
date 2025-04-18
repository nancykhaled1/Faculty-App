import 'package:faculty/ui/auth/login/forget_pass.dart';
import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_field.dart';
class LoginScreen extends StatefulWidget{
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'مرحباً بك من جديد! 👋',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: "Noto Kufi Arabic",
                  fontWeight: FontWeight.w400,
                  color: MyColors.primaryColor,
                ),
              ),
              SizedBox(height: 35.h),
              buildTextField(
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
              SizedBox(
                height: 30.h,
              ),
              buildTextField(
                keyboardType: TextInputType.text,
                hint: 'ادخل كلمة المرور',
                prefixIcon: Padding(
                  padding:  EdgeInsets.only(top: 20.sp,left: 6.sp,right: 6.sp,bottom: 20.sp),
                  child: SvgPicture.asset(
                    'assets/icons/lock.svg', // الأيقونة الافتراضية
                    width: 15.sp,
                    height: 15.sp,
                    colorFilter: ColorFilter.mode(
                      MyColors.greyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                isPassword: isPasswordVisible,
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
                  if (text!.isEmpty || text.trim().isEmpty) {
                    return 'برجاء ادخال كلمة المرور';
                  }
                  if (text.length < 6) {
                    return 'كلمة المرور يجب ألا تقل عن 6 احرف';
                  }
                  return null;
                },
                label: 'كلمة المرور',

              ),
            //  SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: isChecked, onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                        activeColor: MyColors.primaryColor,
                        side: BorderSide(
                          color: MyColors.greyColor,
                        ),
                      ),
                      Text('تذكرني', style: TextStyle(color: MyColors.greyColor, fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic"
                      )),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, ForgetPassScreen.routeName);
                    },
                    child: Text('نسيت كلمة المرور',
                        style: TextStyle(color: MyColors.primaryColor,
                            fontSize: 10.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w400
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  foregroundColor: MyColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 105.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




