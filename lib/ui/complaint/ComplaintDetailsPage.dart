import 'package:faculty/colorManager.dart';
import 'package:faculty/ui/complaint/inquiriesComplaint.dart';

import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Complaintdetailspage extends StatefulWidget {
  const Complaintdetailspage({super.key});

  @override
  State<Complaintdetailspage> createState() => _ComplaintdetailspageState();
}

class _ComplaintdetailspageState extends State<Complaintdetailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 الصف في الأعلى
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inquriescomplaint()),
                    );
                  },
                  child: Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0),
                    child: SvgPicture.asset(
                      "assets/images/Upload.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40.h),

            // 🔸 الكونتينر اللي طلبتيه
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 343.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),  // ✅ ريديوس
                    topLeft: Radius.circular(20.r),   // ✅ ريديوس
                    bottomLeft: Radius.circular(20.r), // ✅ ريديوس
                    bottomRight: Radius.zero,         // ❌ بدون ريديوس
                  ),
                  border: Border.all(
                    color: ColorManager.textColor, // ✅ حدود باللون الأصفر
                    width: 1,             // سمك الحدود
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,top: 25),
                  child: Text(
                    " انا لدي مشكلة في عدد ساعات التسجيل الاكاديمي",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h,),

             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 343.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),  // ✅ ريديوس
                    topLeft: Radius.circular(20.r),   // ✅ ريديوس
                    bottomLeft: Radius.circular(20.r), // ✅ ريديوس
                    bottomRight: Radius.zero,         // ❌ بدون ريديوس
                  ),
                  border: Border.all(
                    color: Color(0XFF84DA4F), // ✅ حدود باللون الأصفر
                    width: 1,             // سمك الحدود
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,top: 25),
                  child: Text(
                 "انت تحتاج للاتجاه لشئون الطلاب",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
