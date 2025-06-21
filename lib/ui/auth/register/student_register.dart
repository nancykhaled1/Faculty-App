import 'package:faculty/ui/auth/register/alumni_register.dart';
import 'package:faculty/ui/auth/register/cubit/studentregisterviewmodel.dart';
import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../domain/usecase/di.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';
import '../authProvider.dart';
import 'cubit/states.dart';

class StudentRegister extends StatefulWidget {
  @override
  State<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {


  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;


  var viewmodel = StudentRegisterViewModel(registerUseCase: injectRegisterUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentRegisterViewModel,RegisterStates>(
      bloc: viewmodel,
        listener:(context, state) {
          if (state is RegisterErrorState) {
          //  BuildDialog.hideLoading(context);
            Navigator.pop(context); // لإغلاق الديالوج لو كان مفتوح
            showDialog(
              context: context,
              builder: (context) => BuildDialog(
                message: state.errorMessage ?? "حدث خطأ غير متوقع",
                image: 'assets/icons/error.svg',

              ),
            );
          }
          if (state is RegisterSuccessState) {
          //  BuildDialog.hideLoading(context);
            Navigator.pop(context); // لإغلاق الديالوج لو كان مفتوح
            Provider.of<AuthProvider>(context, listen: false).login("complaints");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(userType: "complaints"), // أو "complaints"
              ),
            );
           // BuildDialog(message: state.response.username ?? "no username");
          }
          if (state is RegisterLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => BuildDialog(
                message: 'جارٍ انشاء الحساب...',
                image: 'assets/images/vector.svg',

              ),
            );
          }
        },

      child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'مرحباً بك ! 👋',
              style: TextStyle(
                fontSize: 24.sp,
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w400,
                color: MyColors.primaryColor,
              ),
            ),
            SizedBox(height: 35.h),
            Form(
              key: viewmodel.formKey,
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
                    controller: viewmodel.userNameController,
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
                    controller: viewmodel.emailController,
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
                    controller: viewmodel.passwordController,
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
                    controller: viewmodel.rePasswordController,
                    validator: (text) {
                      if (text == null || text.isEmpty)
                        return 'يرجى تأكيد كلمة المرور';
                      if (text != viewmodel.passwordController.text)
                        return 'كلمة المرور غير متطابقة';
                      return null;
                    },
                    label: 'تأكيد كلمة المرور',
                    isPassword: isRePasswordVisible,
                  ),
                  SizedBox(height: 30.h),

                  ElevatedButton(
                    onPressed: () {
                     // if (formKey.currentState!.validate()) {
                      //  Provider.of<AuthProvider>(context, listen: false).login("complaints");
                        viewmodel.studentRegister();

                    //  }
                    },
                    child: Text(
                      "إنشاء حساب",
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
                        horizontal: 115.w,
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
    )
    );
  }
}
