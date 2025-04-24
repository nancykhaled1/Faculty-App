import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationCard extends StatelessWidget {
  final String message;
  final String date;

  const NotificationCard({super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // 🔔 الجزء الأزرق بالأيقونة
            Container(
              width: 50.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: MyColors.primaryColor, // لون أزرق زي الصورة
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r)
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/notification.svg', // أيقونة الجرس
                  // width: 24.w,
                  // height: 24.h,
                  // color: Colors.yellow, // نفس لون الجرس في الصورة
                ),
              ),
            ),

            // 📝 النص والتاريخ
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.bottomLeft, // التاريخ يروح للشمال
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          date,
                          style: TextStyle(
                            fontFamily: 'Numans',
                            fontWeight: FontWeight.w400,
                            fontSize: 9.sp,
                            color: MyColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
