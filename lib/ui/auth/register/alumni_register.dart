import 'package:faculty/ui/auth/register/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_field.dart';
import '../authProvider.dart';

class Register extends StatefulWidget{
  static const String routeName = 'register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController jobController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController emailCompanyController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool showDropdown = false; // تحكم في إظهار القائمة المنسدلة

  String selectedEmploymentStatus = "ادخل حاله التوظيف";

  final List<String> global = [
    "داخل مصر",
    "خارج مصر",

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:MyColors.whiteColor,

        body: SingleChildScrollView(
          child:
          Padding(
            padding:  EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
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
                  key: formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        keyboardType: TextInputType.text,
                        hint: 'ادخل اسم الوظيفة',
                        prefixIcon: Padding(
                          padding:  EdgeInsets.all(15.sp),
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
                        controller: jobController,
                        validator: (text) {
                          if (text!.isEmpty ||
                              text.trim().isEmpty) {
                            return 'برجاء ادخال اسم الوظيفة';
                          }
                          return null;
                        },
                        label: 'اسم الوظيفة',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      _buildDropdown(),
                      SizedBox(
                        height: 30.h,
                      ),
                      buildTextField(
                        keyboardType: TextInputType.emailAddress,
                        hint: 'ادخل البريد الالكتروني للشركة',
                        prefixIcon: Padding(
                          padding:  EdgeInsets.only(top: 14.sp,left: 6.sp,right: 6.sp,bottom: 4.sp),
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
                        controller: emailCompanyController,
                        validator: (text) {
                          if (text!.isEmpty ||
                              text.trim().isEmpty) {
                            return 'برجاء ادخال البريد الالكترونى للشركة';
                          }
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'برجاء ادخال بريد الكترونى صحيح';
                          }
                          return null;
                        },
                        label: 'البريد الالكتروني',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      buildTextField(
                        keyboardType: TextInputType.phone,
                        hint: 'ادخل رقم هاتف الشركة',
                        prefixIcon: Icon(
                          Icons.phone_in_talk,
                          size: 15.sp,
                          color: MyColors.greyColor,
                        ),
                        controller: phoneController,
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'برجاء ادخال رقم هاتف الشركة';
                          }
                          return null;
                        },
                        label: 'رقم الهاتف',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      buildTextField(
                        keyboardType: TextInputType.text,
                        hint: 'ادخل الرابط الخاص بالشركة',
                        prefixIcon: Padding(
                          padding:   EdgeInsets.all(15.sp),
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
                        controller: urlController,
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'برجاءادخال رابط الشركة';
                          }
                          return null;
                        },
                        label: 'رابط الشركة',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      buildTextField(
                        keyboardType: TextInputType.text,
                        hint: 'ادخل وصف عن الشركة',
                        prefixIcon: Padding(
                          padding:   EdgeInsets.all(13.sp),
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
                        controller: descriptionController,
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'برجاء وصف الشركة';
                          }
                          return null;
                        },
                        label: 'وصف الشركة',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()){
                            Provider.of<AuthProvider>(context, listen: false).login('graduates');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(userType: "graduates"), // أو "complaints"
                              ),
                            );

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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
  }



  Widget _buildDropdown() {
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
              label: 'محل الشركة',
              hint: 'اختار محل الشركة',
              controller: locationController,
              readonly: true,
              suffixIcon: Icon(
                showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down, // تغيير الأيقونة
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
        if (showDropdown)
          Column(
            children: global.map((status) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedEmploymentStatus = status;
                    locationController.text = status;
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

}