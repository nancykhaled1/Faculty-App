import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BuildDialog extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback? onDismiss; // دالة اختيارية للتنفيذ عند النقر

  const BuildDialog({
    Key? key,
    required this.message,
    this.subMessage,
    this.onDismiss, // السماح بتمرير دالة تنفيذية عند النقر
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/vector.svg',
              width: 61.w,
              height: 61.h,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding:  EdgeInsets.symmetric(
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
              Text(
                subMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
