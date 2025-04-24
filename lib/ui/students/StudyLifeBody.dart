import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudyLifeBody extends StatelessWidget {


  final List<Map<String, dynamic>> items = [
    {
      'title': 'التربية العسكرية',
      'subtitle': 'اذا كنت تريد صيغة استمارة التربية العسكرية',
      'icon': 'assets/icons/Vector 1.svg',
    },
    {
      'title': 'الدليل الاكاديمى',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل الدليل الأكاديمى',
      'icon': 'assets/icons/_Group_.svg',
    },
    {
      'title': 'الفرق الدراسية',
      'subtitle': 'اذا كنت تريد معرفة الفرق الدراسية',
      'icon': 'assets/icons/Pencil and pen.svg',
    },
    {
      'title': 'اللائحة و القوانين',
      'subtitle': 'اذا كنت تريد معرفة اللائحة الدراسية',
      'icon': 'assets/icons/Wirite.svg',
    },
    {
      'title': 'المنح الدراسية',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل المنح',
      'icon': 'assets/icons/Vector.svg',
    },
    {
      'title': 'شروط التقديم',
      'subtitle': 'اذا كنت تريد معرفة شروط التقديم',
      'icon': 'assets/icons/document-file-sharing.svg',
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



