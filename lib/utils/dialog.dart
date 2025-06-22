import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BuildDialog extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback? onDismiss; // دالة اختيارية للتنفيذ عند النقر
  final String? image;

  const BuildDialog({
    Key? key,
    required this.message,
    this.subMessage,
    this.onDismiss, // السماح بتمرير دالة تنفيذية عند النقر
    this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // إغلاق الـ Dialog
        if (onDismiss != null) {
          onDismiss!(); // تنفيذ الدالة إذا تم تمريرها
        }
      },
      child: AlertDialog(
        backgroundColor: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        contentPadding: EdgeInsets.only(top: 30.h, bottom: 40.h),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null && image!.isNotEmpty)
                SvgPicture.asset(
                  image!,
                  width: 61.w,
                  height: 61.h,
                ),
              if (image != null && image!.isNotEmpty)
                SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 20.h
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Noto Kufi Arabic",
                    color: MyColors.blackColor,
                  ),
                ),
              ),
              if (subMessage != null) ...[
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Text(
                    subMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp, 
                      color: Colors.grey[700],
                      fontFamily: "Noto Kufi Arabic",
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
