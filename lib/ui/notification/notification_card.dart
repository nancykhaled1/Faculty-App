import 'package:faculty/domain/entities/notificationEntity.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';


class NotificationCard extends StatelessWidget {
  final NotificationResponseEntity notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final DateTime parsedDate = DateTime.parse(notification.createdAt ??'').toLocal();
    final String formattedDate = DateFormat('HH:mm – dd/MM/yyyy').format(parsedDate);
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
            Container(
              width: 50.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r)
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/notification.svg',
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? '',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      notification.body ?? '',
                      style: TextStyle(
                        fontFamily: 'Noto Kufi Arabic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontFamily: 'Numans',
                          fontWeight: FontWeight.w400,
                          fontSize: 9.sp,
                          color: MyColors.greyColor,
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
