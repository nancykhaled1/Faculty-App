import 'package:faculty/ui/students/student-activity-screen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentLifeBody extends StatelessWidget {


  final List<Map<String, dynamic>> items = [
    {
      'title': 'أنشطة طلابية',
      'subtitle': 'اذا كنت تريد تفاصيل أنشطه طلابية',
      'icon': 'assets/icons/users-two.svg',
      'actionType': 'screen',
      'data': 'activity',
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
              final actionType = item['actionType'];
              final data = item['data'];

              switch (actionType) {
              // case 'pdf':
              // // افتح ملف PDF
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => PdfViewerScreen(pdfPath: data),
              //     ),
              //   );
              //   break;
              //
              // case 'link':
              // // افتح لينك في المتصفح
              //   launchUrl(Uri.parse(data));
              //   break;

                case 'screen':
                // افتح شاشة داخل التطبيق
                  if (data == 'activity') {
                    Navigator.pushNamed(context, StudentActivityScreen.routeName);
                  }
                  break;
              }
            },
          );
        },
      ),
    );
  }


}



