import 'package:faculty/ui/auth/login/cubit/states.dart';
import 'package:faculty/ui/auth/login/forget_pass.dart';
import 'package:faculty/ui/complaint/complaint.dart';
import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import '../../../data/local/alumni_model.dart';
import '../../../data/local/preferences.dart';
import '../../../domain/usecase/di.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';
import '../../alumni/cubit/profileviewmodel.dart';
import '../../alumni/cubit/states.dart';
import '../authProvider.dart';
import '../register/alumniregisterscreen.dart';
import 'cubit/loginscreenviewmodel.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  final String userType; // graduates or complaints (students)

  const LoginScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  var viewModel = LoginScreenViewModel(loginUseCase: injectLoginUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewModel,LoginStates>(
      bloc: viewModel,
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => BuildDialog(
                message: 'جارٍ تسجيل الدخول...',
              ),
            );
          }

          if (state is LoginErrorState) {
            Navigator.pop(context); // لإغلاق الديالوج لو كان مفتوح
            showDialog(
              context: context,
              builder: (context) => BuildDialog(
                message: state.errorMessage ?? "حدث خطأ غير متوقع",
              ),
            );
          }

          if (state is LoginSuccessState) {
            Navigator.pop(context); // إغلاق الديالوج

            _handleLoginSuccess(state.response.access!);
          }


        },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
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
                    padding: EdgeInsets.only(
                      top: 14.sp,
                      left: 6.sp,
                      right: 6.sp,
                      bottom: 4.sp,
                    ),
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
                  controller: viewModel.emailController,
                  validator: (text) {
                    if (text!.isEmpty || text.trim().isEmpty) {
                      return 'برجاء ادخال البريد الالكترونى';
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
                  keyboardType: TextInputType.text,
                  hint: 'ادخل كلمة المرور',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      top: 20.sp,
                      left: 6.sp,
                      right: 6.sp,
                      bottom: 20.sp,
                    ),
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
                  isPassword: viewModel.isPasswordVisible,
                  suffixIcon: Icon(
                    viewModel.isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18.sp,
                    color: MyColors.greyColor,
                  ),
                  suffixIconFunction: () {
                    setState(() {
                      viewModel.isPasswordVisible = !viewModel.isPasswordVisible;
                    });
                  },
                  controller: viewModel.passwordController,
                  validator: (text) {
                    // if (text!.isEmpty || text.trim().isEmpty) {
                    //   return 'برجاء ادخال كلمة المرور';
                    // }
                    // if (text.length < 6) {
                    //   return 'كلمة المرور يجب ألا تقل عن 6 احرف';
                    // }
                    // return null;
                  },
                  label: 'كلمة المرور',
                ),
                //  SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: viewModel.isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              viewModel.isChecked = value!;
                            });
                          },
                          activeColor: MyColors.primaryColor,
                          side: BorderSide(color: MyColors.greyColor),
                        ),
                        Text(
                          'تذكرني',
                          style: TextStyle(
                            color: MyColors.greyColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          ForgetPassScreen.routeName,
                        );
                      },
                      child: Text(
                        'نسيت كلمة المرور',
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 10.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                ElevatedButton(
                  onPressed: () {
                    viewModel.login();

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
                      horizontal: 105.w,
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

    );


  }
  void _handleLoginSuccess(String token) async {
   // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
   // final userId = decodedToken['user_id'];

    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.getUserData(token);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userData = profileViewModel.state is UserDataSuccessStates
        ? (profileViewModel.state as UserDataSuccessStates).userDataResponseEntity
        : null;

    if (userData != null) {
      authProvider.setAlumniData(userData);
      authProvider.setToken(token);
      authProvider.login(widget.userType);

      // استخراج البيانات من الكائن:
      final employmentStatus = userData.graduationData?.employmentStatus ?? '';
      final username = userData.graduationData?.user?.username ?? '';
      final email = userData.graduationData?.user?.email ?? '';

      // حفظ البيانات في SharedPreferences
      if (employmentStatus == "employee") {
        await SharedPrefsHelper.saveUserData(
          username: username,
          email: email,
          employmentStatus: employmentStatus,
          jobName: userData.graduationData?.jobName,
          companyEmail: userData.graduationData?.companyEmail,
          companyPhone: userData.graduationData?.companyPhone,
          companyLink: userData.graduationData?.companyLink,
          aboutCompany: userData.graduationData?.aboutCompany,

        );
      } else {
        await SharedPrefsHelper.saveUserData(
          username: username,
          email: email,
          employmentStatus: employmentStatus,
        );
      }
      await SharedPrefsHelper.setToken(token); // ✅ مهم جدًا

      if (widget.userType == "graduates") {
        Navigator.pushNamed(context, HomePage.routeName);
      } else {
        Navigator.pushNamed(context, Complaint.routeName);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => BuildDialog(
          message: 'فشل في تحميل بيانات المستخدم',
        ),
      );
    }
  }

}


