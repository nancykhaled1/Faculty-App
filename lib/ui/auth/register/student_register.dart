import 'package:faculty/ui/auth/register/alumni_register.dart';
import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_field.dart';

class StudentRegister extends StatefulWidget {
  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController employmentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'مرحباً بك ! 👋',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.primaryColor,
              ),
            ),
            SizedBox(height: 35.h),
            Form(
              key: formKey,
              child: Column(
                children: [
                  buildTextField(
                    keyboardType: TextInputType.text,
                    hint: 'ادخل اسمك',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        top: 14.sp,
                        left: 6.sp,
                        right: 6.sp,
                        bottom: 4.sp,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/user.svg', // الأيقونة الافتراضية
                        width: 15.sp,
                        height: 15.sp,
                        // colorFilter: ColorFilter.mode(
                        //   Color(0xFF7A7A7A),
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    ),
                    controller: userNameController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'برجاء ادخال اسمك';
                      } return null;
                    },
                    label: 'اسم المستخدم',
                  ),
                  SizedBox(height: 30.h),

                  buildTextField(
                    keyboardType: TextInputType.emailAddress,
                    hint: 'ادخل بريدك الالكتروني',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        top: 15.sp,
                        left: 6.sp,
                        right: 6.sp,
                        bottom: 5.sp,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/mail.svg', // الأيقونة الافتراضية
                        width: 15.sp,
                        height: 15.sp,
                        // colorFilter: ColorFilter.mode(
                        //   Color(0xFF7A7A7A),
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    ),
                    controller: emailController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'برجاء ادخال البريد الالكتروني';
                      }
                      bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text);
                      if (!emailValid) {
                        return 'برجاء ادخال بريد الكتروني صحيح';
                      }
                      return null;
                    },
                    label: 'البريد الالكتروني',
                  ),
                  SizedBox(height: 30.h),

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
                  SizedBox(height: 30.h),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                          context,
                          SuccessScreen.routeName,
                        );
                      }
                    },
                    child: Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: MyColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 120.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
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
