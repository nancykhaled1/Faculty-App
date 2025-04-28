import 'package:faculty/ui/auth/register/alumni_register.dart';
import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_field.dart';
import '../authProvider.dart';

class AlumniRegisterScreen extends StatefulWidget {
  @override
  State<AlumniRegisterScreen> createState() => _AlumniRegisterScreenState();
}

class _AlumniRegisterScreenState extends State<AlumniRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController employmentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isRePasswordVisible = true;

  bool isPasswordVisible = true;
  bool showField = false; // تحكم في إظهار السيرة الذاتية
  bool showDropdown = false; // تحكم في إظهار القائمة المنسدلة

  String selectedEmploymentStatus = "ادخل حاله التوظيف"; // القيمة الافتراضية
  String? resumeFilePath; // مسار السيرة الذاتية

  final Map<String, String> employmentIcons = {
    "موظف": "assets/icons/user-tick.svg",
    "باحث عن عمل": "assets/icons/user-settings.svg",
    "غير موظف": "assets/icons/user-cross.svg",
    "طالب دراسات عليا": "assets/icons/user-shield.svg",
    "يعمل عامل حر": "assets/icons/user-heart.svg",
  };

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
                fontFamily: "Noto Kufi Arabic",
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


                  // زر تحميل السيرة الذاتية
                  // عرض رفع السيرة الذاتية وحالة التوظيف معًا عند اختيار "خريج"
                 // if (showField)
                  SizedBox(height: 30.h),

                  _buildResumeUploadField(),
                    SizedBox(height: 30.h),
                    _buildEmploymentStatusDropdown(),

                  SizedBox(height: 40.h),
                  ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Provider.of<AuthProvider>(context, listen: false).login();
                            if (selectedEmploymentStatus == "موظف") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuccessScreen(userType: "graduates"), // أو "complaints"
                                ),
                              );

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
    );
  }



  Widget _buildResumeUploadField() {
    return buildTextField(
      label: 'السيرة الذاتية',
      hint: resumeFilePath ?? 'قم بتحميل الملف',
      controller: TextEditingController(text: resumeFilePath ?? ''),
      validator: (text) {
        if (resumeFilePath == null) {
          return 'يرجى تحميل السيرة الذاتية';
        }
        return null;
      },
      prefixIcon: GestureDetector(
        onTap: pickResumeFile,
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

  Widget _buildEmploymentStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              showDropdown = !showDropdown;
            });
          },
          child: AbsorbPointer(
            child: buildTextField(
              label: 'حالة التوظيف',
              hint: 'اختار حالة التوظيف',
              controller: employmentController,
              readonly: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showDropdown = !showDropdown;
                  });
                },
                child: Icon(
                  showDropdown
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
                  employmentIcons[selectedEmploymentStatus] ??
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
        if (showDropdown)
          Column(
            children:
                employmentIcons.entries.map((entry) {
                  String status = entry.key;
                  String iconPath = entry.value;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmploymentStatus = status;
                        employmentController.text = status; // تحديث النص داخل `TextEditingController`
                        showDropdown = false;
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

  Future<void> pickResumeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        resumeFilePath = result.files.single.name;
      });
    }
  }
}
