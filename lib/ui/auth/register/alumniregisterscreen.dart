import 'dart:io';

import 'package:faculty/ui/auth/register/alumni_register.dart';
import 'package:faculty/ui/auth/register/cubit/states.dart';
import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../data/local/preferences.dart';
import '../../../domain/usecase/di.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';
import '../authProvider.dart';
import 'cubit/alumniregisterviewmodel.dart';

class AlumniRegisterScreen extends StatefulWidget {
  @override
  State<AlumniRegisterScreen> createState() => _AlumniRegisterScreenState();
}

class _AlumniRegisterScreenState extends State<AlumniRegisterScreen> {



  var viewmodel = AlumniRegisterScreenViewModel(registerUseCase: injectRegisterUseCase());



  @override
  Widget build(BuildContext context) {
    return BlocListener<AlumniRegisterScreenViewModel,RegisterStates>(
      bloc: viewmodel,
        listener: (context, state) async {
          if (state is AlumniRegisterErrorState) {
            Navigator.pop(context); // <-- قفل الـ dialog
            showDialog(
              context: context,
              builder: (context) => BuildDialog(
                message: state.errorMessage ?? "حدث خطأ غير متوقع",
              ),
            );
          }

          if (state is AlumniRegisterLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false, // لا يمكن اغلاق الديالوج بالضغط بالخارج
              builder: (_) => WillPopScope(
                onWillPop: () async => false, // يمنع زر الرجوع أيضاً
                child: BuildDialog(message: 'جارٍ انشاء الحساب...'),
              ),
            );

          }

          if (state is AlumniRegisterSuccessState) {
            Navigator.pop(context);

            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            authProvider.login("graduates");


            await SharedPrefsHelper.saveUserData(
              username: viewmodel.userNameController.text,
              email: viewmodel.emailController.text,
              employmentStatus: viewmodel.selectedEmploymentStatus ?? '',
              aboutCompany: state.response.aboutCompany ?? '',
              companyEmail: state.response.companyEmail ?? '',
              companyLink: state.response.companyLink ?? '',
              companyPhone: state.response.companyPhone ?? '',
              jobName: state.response.jobName ?? '',
              location: state.response.location ?? '',
              cv: state.response.cv ?? ''
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(userType: "graduates"),
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
                      suffixIcon: Icon( viewmodel.isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                        size: 18.sp,color: MyColors.greyColor,),
                      suffixIconFunction: () {
                        setState(() {
                          viewmodel.isPasswordVisible = !viewmodel.isPasswordVisible;
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
                      isPassword: viewmodel.isPasswordVisible,
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
                          'assets/icons/lock.svg',
                          width: 15.sp,
                          height: 15.sp,
                          // colorFilter: ColorFilter.mode(
                          //   Color(0xFF7A7A7A),
                          //   BlendMode.srcIn,
                          // ),
                        ),
                      ),
                      suffixIcon: Icon( viewmodel.isRePasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                        size: 18.sp,color: MyColors.greyColor,),
                      suffixIconFunction: () {
                        setState(() {
                          viewmodel.isRePasswordVisible = !viewmodel.isRePasswordVisible;
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
                      isPassword: viewmodel.isRePasswordVisible,
                    ),


                    // زر تحميل السيرة الذاتية
                    // عرض رفع السيرة الذاتية وحالة التوظيف معًا عند اختيار "خريج"
                    // if (showField)

                    SizedBox(height: 30.h),
                    _buildEmploymentStatusDropdown(),

                    SizedBox(height: 40.h),
                    ElevatedButton(
                      onPressed: () {
                        // أولاً تأكد من أن كل الحقول الأخرى صحيحة
                        if (viewmodel.formKey.currentState!.validate()) {

                          // تحقق من السي

                          // بيانات التسجيل
                          AlumniRegisterData data = AlumniRegisterData(
                            username: viewmodel.userNameController.text,
                            email: viewmodel.emailController.text,
                            password: viewmodel.passwordController.text,
                            repeatPassword: viewmodel.rePasswordController.text,
                            employmentStatus: viewmodel.selectedEmploymentStatus ?? '',
                          );

                          // هل هو موظف؟
                          if (viewmodel.selectedEmploymentStatus == "موظف") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(registerData: data),
                              ),
                            );
                          } else {
                            viewmodel.alumniRegister(data);
                          }
                        }
                      },




                      child: Text(
                        "التالي",
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
                          horizontal: 130.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ) ,
    );

  }





  Widget _buildEmploymentStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () {
            setState(() {
              viewmodel.showDropdown = !viewmodel.showDropdown;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              label: 'حالة التوظيف',
              hint: 'اختار حالة التوظيف',
              controller: viewmodel.employmentController,
              readonly: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    viewmodel.showDropdown = !viewmodel.showDropdown;
                  });
                },
                child: Icon(
                  viewmodel.showDropdown
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down, // تغيير الأيقونة
                  size: 35.sp,
                  color: MyColors.primaryColor,
                ),
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'برجاء اختيار حالة التوظيف';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: 15.sp,
                  left: 6.sp,
                  right: 6.sp,
                  bottom: 4.sp,
                ),
                child: SvgPicture.asset(
                  viewmodel.employmentIcons[viewmodel.selectedEmploymentStatus] ??
                      'assets/icons/user.svg', // الأيقونة الافتراضية
                  width: 18.sp,
                  height: 18.sp,
                  // colorFilter: ColorFilter.mode(
                  //   Color(0xFF7A7A7A),
                  //   BlendMode.srcIn,
                  // ),
                ),
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (viewmodel.showDropdown)
          Column(
            children:
            viewmodel.employmentIcons.entries.map((entry) {
                  String status = entry.key;
                  String iconPath = entry.value;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        viewmodel.selectedEmploymentStatus = status;
                        viewmodel.employmentController.text = status; // تحديث النص داخل `TextEditingController`
                        viewmodel.showDropdown = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.primaryColor),
                        borderRadius: BorderRadius.circular(10.r),
                        color: MyColors.whiteColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            iconPath,
                            width: 18.sp,
                            height: 18.sp,
                            // colorFilter: ColorFilter.mode(
                            //   Color(0xFF7A7A7A),
                            //   BlendMode.srcIn,
                            // ),
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            status,
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
      ],
    );
  }


}

class AlumniRegisterData {
  final String username;
  final String email;
  final String password;
  final String repeatPassword;
  final String employmentStatus;

  final String? jobName;
  final String? location;
  final String? companyEmail;
  final String? companyPhone;
  final String? companyLink;
  final String? cv;
  final String? aboutCompany;

  AlumniRegisterData({
    required this.username,
    required this.email,
    required this.password,
    required this.repeatPassword,
    required this.employmentStatus,
    this.jobName,
    this.location,
    this.companyEmail,
    this.companyPhone,
    this.companyLink,
    this.cv,
    this.aboutCompany
  });

  // ⬇️ copyWith method
  AlumniRegisterData copyWith({
    String? username,
    String? email,
    String? password,
    String? repeatPassword,
    String? employmentStatus,
    String? jobName,
    String? location,
    String? companyEmail,
    String? companyPhone,
    String? companyLink,
    String? cv,
    String? aboutCompany
  }) {
    return AlumniRegisterData(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      jobName: jobName ?? this.jobName,
      location: location ?? this.location,
      companyEmail: companyEmail ?? this.companyEmail,
      companyPhone: companyPhone ?? this.companyPhone,
      companyLink: companyLink ?? this.companyLink,
      cv: cv ?? this.cv,
      aboutCompany: aboutCompany ?? this.aboutCompany
    );
  }
}



