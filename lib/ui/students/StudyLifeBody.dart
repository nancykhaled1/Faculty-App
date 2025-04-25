import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/students/scholarships-screen.dart';
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
      'actionType': 'pdf',
      'data': 'assets/pdfs/military_form.pdf',
    },
    {
      'title': 'الدليل الاكاديمى',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل الدليل الأكاديمى',
      'icon': 'assets/icons/_Group_.svg',
      'actionType': 'pdf',
      'data': 'https://university.example.com/guide',
    },
    {
      'title': 'الفرق الدراسية',
      'subtitle': 'اذا كنت تريد معرفة الفرق الدراسية',
      'icon': 'assets/icons/Pencil and pen.svg',
      'actionType': 'screen',
      'data': 'academicTeams', // اسم الشاشة
    },
    {
      'title': 'اللائحة و القوانين',
      'subtitle': 'اذا كنت تريد معرفة اللائحة الدراسية',
      'icon': 'assets/icons/Wirite.svg',
      'actionType': 'pdf',
      'data': 'assets/pdfs/regulations.pdf',
    },
    {
      'title': 'المنح الدراسية',
      'subtitle': 'اذا كنت تريد معرفة تفاصيل المنح',
      'icon': 'assets/icons/Vector.svg',
      'actionType': 'screen',
      'data': 'ScholarshipScreen',
    },
    {
      'title': 'شروط التقديم',
      'subtitle': 'اذا كنت تريد معرفة شروط التقديم',
      'icon': 'assets/icons/document-file-sharing.svg',
      'actionType': 'pdf',
      'data': 'https://university.example.com/admission',
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
                  if (data == 'academicTeams') {
                    Navigator.pushNamed(context, AcademicTeams.routeName);
                  } else if (data == 'ScholarshipScreen') {
                    Navigator.pushNamed(context, ScholarshipsScreen.routeName);
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



