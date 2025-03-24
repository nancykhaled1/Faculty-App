import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buildTextField extends StatelessWidget {
  String label;
  String hint;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool isPassword;
  bool isobscure;
  Widget? suffixIcon;
  Widget? prefixIcon;
  void Function()? suffixIconFunction;
  bool readonly;

  buildTextField({
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.isobscure = false,
    this.suffixIconFunction,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      textAlign: TextAlign.right,
      controller: controller,
      style: TextStyle(
          color: Color(0xFF7A7A7A), fontSize: 14.sp // جعله أكثر وضوحًا
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 13.h),
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF044C8C), fontSize: 15.sp),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Color(0xFF7A7A7A), fontSize: 14.sp),
        prefixIcon: prefixIcon,
        suffixIcon:
        suffixIcon != null
            ? InkWell(onTap: suffixIconFunction, child: suffixIcon)
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF044C8C)), // إطار افتراضي
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF044C8C), width: 2), // عند التركيز
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA90714), width: 2), // لون الخطأ
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA90714), width: 2), // عند التركيز مع خطأ
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
