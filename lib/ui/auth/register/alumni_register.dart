import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../data/local/preferences.dart';
import '../../../domain/usecase/di.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialog.dart';
import '../../../utils/text_field.dart';
import '../authProvider.dart';
import 'alumniregisterscreen.dart';
import 'cubit/alumniregisterviewmodel.dart';
import 'cubit/states.dart';

class Register extends StatefulWidget {
  final AlumniRegisterData registerData;

  const Register({Key? key, required this.registerData}) : super(key: key);

  static const String routeName = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var viewmodel = AlumniRegisterScreenViewModel(
    registerUseCase: injectRegisterUseCase(),
  );

  @override
  void initState() {
    super.initState();
    print("📥 Received RegisterData:");
    print("email: ${widget.registerData.email}");
    print("username: ${widget.registerData.username}");
    print("password: ${widget.registerData.password}");
    print("repeatPassword: ${widget.registerData.repeatPassword}");
    print("employmentStatus: ${widget.registerData.employmentStatus}");

  }

  Future<void> completeRegistration() async {
    final data = widget.registerData.copyWith(
      jobName: viewmodel.jobController.text,
      location: viewmodel.locationController.text,
      companyEmail: viewmodel.emailCompanyController.text,
      companyPhone: viewmodel.phoneController.text,
      companyLink: viewmodel.urlController.text,
      cv: viewmodel.resumeFilePath, // لو فيه رفع سيرة ذاتية
      aboutCompany: viewmodel.descriptionController.text,
    );

    viewmodel.alumniRegister(data);
    await SharedPrefsHelper.saveUserData(
      username: data.username,
      email: data.email,
      employmentStatus: data.employmentStatus,
      jobName: data.jobName,
      companyEmail: data.companyEmail,
      companyPhone: data.companyPhone,
      companyLink: data.companyLink,
      aboutCompany: data.aboutCompany,
      location: data.location,
      cv: data.cv
    );


  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AlumniRegisterScreenViewModel, RegisterStates>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is AlumniRegisterErrorState) {
          //  BuildDialog.hideLoading(context);
          Navigator.pop(context); // <-- قفل الـ dialog

          showDialog(
            context: context,
            builder:
                (context) => BuildDialog(
                  message: state.errorMessage ?? "حدث خطأ غير متوقع",
                  image: 'assets/icons/error.svg',
                ),
          );
        }
        if (state is AlumniRegisterLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false, // لا يمكن اغلاق الديالوج بالضغط بالخارج
            builder:
                (_) => WillPopScope(
                  onWillPop: () async => false, // يمنع زر الرجوع أيضاً
                  child: BuildDialog(message: 'جارٍ انشاء الحساب...',
                    image: 'assets/images/vector.svg',

                  ),
                ),
          );
        }
        if (state is AlumniRegisterSuccessState) {
          //  BuildDialog.hideLoading(context);

          Navigator.pop(context); // <-- قفل الـ dialog

          // Provider.of<AuthProvider>(context, listen: false).login('graduates');

          final authProvider = Provider.of<AuthProvider>(
            context,
            listen: false,
          );
          authProvider.login("graduates");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      SuccessScreen(userType: "graduates"), // أو "complaints"
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg', // الأيقونة الافتراضية
                      width: 30.sp,
                      height: 30.sp,
                      // color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Form(
                    key: viewmodel.formKey,
                    child: Column(
                      children: [
                        buildTextField(
                          keyboardType: TextInputType.text,
                          hint: 'ادخل اسم الوظيفة',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: SvgPicture.asset(
                              'assets/icons/suit.svg', // الأيقونة الافتراضية
                              width: 10.sp,
                              height: 10.sp,
                              // colorFilter: ColorFilter.mode(
                              //   MyColors.greyColor,
                              //   BlendMode.srcIn,
                              // ),
                            ),
                          ),
                          controller: viewmodel.jobController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'برجاء ادخال اسم الوظيفة';
                            }
                            return null;
                          },
                          label: 'اسم الوظيفة',
                        ),
                        SizedBox(height: 30.h),

                        _buildResumeUploadField(),
                        SizedBox(height: 30.h),
                        _buildDropdown(),
                        SizedBox(height: 30.h),
                        buildTextField(
                          keyboardType: TextInputType.emailAddress,
                          hint: 'ادخل البريد الالكتروني للشركة',
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
                              // colorFilter: ColorFilter.mode(
                              //   Color(0xFF7A7A7A),
                              //   BlendMode.srcIn,
                              // ),
                            ),
                          ),
                          controller: viewmodel.emailCompanyController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'برجاء ادخال البريد الالكترونى للشركة';
                            }
                            bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(text);
                            if (!emailValid) {
                              return 'برجاء ادخال بريد الكترونى صحيح';
                            }
                            return null;
                          },
                          label: 'البريد الالكتروني',
                        ),
                        SizedBox(height: 30.h),
                        buildTextField(
                          keyboardType: TextInputType.phone,
                          hint: 'ادخل رقم هاتف الشركة',
                          prefixIcon: Icon(
                            Icons.phone_in_talk,
                            size: 15.sp,
                            color: MyColors.greyColor,
                          ),
                          controller: viewmodel.phoneController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'برجاء ادخال رقم هاتف الشركة';
                            }
                            return null;
                          },
                          label: 'رقم الهاتف',
                        ),
                        SizedBox(height: 30.h),
                        buildTextField(
                          keyboardType: TextInputType.text,
                          hint: 'ادخل الرابط الخاص بالشركة',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: SvgPicture.asset(
                              'assets/icons/attach.svg', // الأيقونة الافتراضية
                              width: 15.sp,
                              height: 15.sp,
                              // colorFilter: ColorFilter.mode(
                              //   Color(0xFF7A7A7A),
                              //   BlendMode.srcIn,
                              // ),
                            ),
                          ),
                          controller: viewmodel.urlController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'برجاءادخال رابط الشركة';
                            }
                            return null;
                          },
                          label: 'رابط الشركة',
                        ),
                        SizedBox(height: 30.h),
                        buildTextField(
                          keyboardType: TextInputType.text,
                          hint: 'ادخل وصف عن الشركة',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(13.sp),
                            child: SvgPicture.asset(
                              'assets/icons/document.svg', // الأيقونة الافتراضية
                              width: 15.sp,
                              height: 15.sp,
                              // colorFilter: ColorFilter.mode(
                              //   Color(0xFF7A7A7A),
                              //   BlendMode.srcIn,
                              // ),
                            ),
                          ),
                          controller: viewmodel.descriptionController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'برجاء وصف الشركة';
                            }
                            return null;
                          },
                          label: 'وصف الشركة',
                        ),
                        SizedBox(height: 30.h),
                        ElevatedButton(
                          onPressed: () {
                            if (viewmodel.formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              completeRegistration(); // 👈 استدعاء التسجيل النهائي

                            }
                            // بعد الضغط على زر "تسجيل"
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewmodel.showDropdown = !viewmodel.showDropdown;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              label: 'محل الشركة',
              hint: 'اختار محل الشركة',
              controller: viewmodel.locationController,
              readonly: true,
              suffixIcon: Icon(
                viewmodel.showDropdown
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.primaryColor,
              ),
              validator: (text) {
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'برجاء اختيار محل الشركة';
                }
                return null;
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(15.sp),
                child: SvgPicture.asset(
                  'assets/icons/globe-alt.svg',
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
                viewmodel.global.map((status) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        viewmodel.selectedEmploymentStatus = status;
                        viewmodel.locationController.text = status;
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
                            'assets/icons/globe-alt.svg',
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

  Widget _buildResumeUploadField() {
    return buildTextField(
      label: 'السيرة الذاتية',
      hint: viewmodel.resumeFilePath ?? 'قم بتحميل الملف',
      controller: viewmodel.resumeController,
      validator: (text) {
        // if (viewmodel.selectedEmploymentStatus != "موظف" &&
        //     viewmodel.resumeFilePath == null) {
        //   return 'يرجى تحميل السيرة الذاتية';
        // }
        // return null;
      },

      prefixIcon: GestureDetector(
        onTap: viewmodel.pickResumeFile,
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.sp,
            left: 5.sp,
            right: 5.sp,
            bottom: 5.sp,
          ),
          child: SvgPicture.asset(
            'assets/icons/downloadicon.svg', // الأيقونة الافتراضية
            width: 18.sp,
            height: 18.sp,
            // colorFilter: ColorFilter.mode(Color(0xFF7A7A7A), BlendMode.srcIn),
          ),
        ),
      ),
      readonly: true,
    );
  }
}
