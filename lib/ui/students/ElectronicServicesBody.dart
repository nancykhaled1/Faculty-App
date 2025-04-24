import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElectronicServicesBody extends StatelessWidget {


  final List<Map<String, dynamic>> items = [
    {
      'title': 'تسجيل المواد',
      'subtitle': 'اذا كنت تريد معرفه تفاصيل تسجيل المواد',
      'icon': 'assets/icons/materials.svg',
      'actionType': 'Link',
      'data': 'link', // اسم الشاشة
    },
    {
      'title': 'نتائج الطلاب',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل نتائج الطلاب',
      'icon': 'assets/icons/result.svg',
      'actionType': 'Link',
      'data': 'link', // اسم الشاشة
    },
    {
      'title': 'SIS',
      'subtitle': 'اذا كنت تريد معرفة SIS',
      'icon': 'assets/icons/SIS.svg',
      'actionType': 'Link',
      'data': 'link', // اسم الشاشة
    },
    {
      'title': 'خدمات طبية',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل خدمات طبية',
      'icon': 'assets/icons/services.svg',
      'actionType': 'Link',
      'data': 'link', // اسم الشاشة
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: items.length,
        // padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading:Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h , vertical: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                border: Border.all(color: MyColors.primaryColor),
              ),
              child: SvgPicture.asset(
                item['icon'],
                width: 25,
                height: 25,
                // size: 30,
                // color: Colors.blue,
              ),
            ),
            title: Text(item['title'], style: TextStyle(
                color: MyColors.softBlackColor,
                fontFamily: "Noto Kufi Arabic",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
            subtitle: Text(item['subtitle'],
                style: TextStyle(
                    color: MyColors.greyColor,
                    fontFamily: "Noto Kufi Arabic",
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500)),

            onTap: () {
              // TODO: فتح تفاصيل
            },
          );
        },
      ),
    );
  }
}



