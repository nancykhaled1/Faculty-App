import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class SuccessScreen extends StatelessWidget{
  static const String routeName = 'success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Padding(
        padding:  EdgeInsets.only(top: 40.sp),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/vector.svg', // الأيقونة الافتراضية
               // width: 15.sp,
               // height: 15.sp,

              ),
              SizedBox(
                height: 50.h,
              ),
              Text('تم انشاء حسابك بنجاح',
              style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 30.sp,
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text('مرحبا بك من جديد',
                style: TextStyle(
                    color: MyColors.greyColor,
                    fontSize: 20.sp,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomePage.routeName);

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
      ),
    );
  }

}