import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dept_details.dart';

class Department extends StatelessWidget{
  static const String routeName = 'dept';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Stack(
              children: [
                Positioned(
                  top: 200.h,
                    right: 20.w,
                    child: Image.asset('assets/images/line2.png')),
                Positioned(
                    top: 410.h,
                    right: 190.w,
                    child: Image.asset('assets/images/line.png')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الاقسام المتاحة',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Noto Kufi Arabic"
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight, // العنصر الأول على اليمين
                      child: _buildDepartmentCard(imagePath: 'assets/images/cs.png',
                          title: 'قسم علوم الحاسب CS',
                        description: '''يهتم القسم بتدريس وإجراء البحوث المتعلقة بالموضوعات والتخصصات العلمية التالية:أساسيات ومفاهيم لغات الحاسب ومترجماتها – لغة البرمجة – هياكل البيانات – تحليل وتصميم الخوارزميات – نظم تشغيل الحاسبات – بنية وتنظيم الحاسبات- تشفير البيانات وامن الحاسب – ضغط البيانات- هندسة البرمجيات – الذكاء الاصطناعي- النظم الذكية- النظم الخبيرة- معالجة الصور- معالجة اللغات الطبيعية – نظم الوكلاء المتعددة – نظم قواعد المعرفة – المعالجة على التوازي والنظم الموزعة – الحوسبة الشبكية والسحابية- نظم التعليم الذكية – تعليم الحاسبات – التعرف على النماذج – طرق اتصال الانسان بالحاسب – الرؤية بالحاسب – نظم الرسم بالحاسب- تعريب الحاسبات – برمجة التطبيقات.''',
                          context: context
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft, // العنصر الثاني على اليسار
                      child:  _buildDepartmentCard(imagePath: 'assets/images/it.png',
                          title: 'قسم تكنولوجيا المعلومات IT',
                          description: '''يهتم القسم بتدريس وإجراء البحوث المتعلقة بالموضوعات والتخصصات العلمية التالية:أساسيات ومفاهيم لغات الحاسب ومترجماتها – لغة البرمجة – هياكل البيانات – تحليل وتصميم الخوارزميات – نظم تشغيل الحاسبات – بنية وتنظيم الحاسبات- تشفير البيانات وامن الحاسب – ضغط البيانات- هندسة البرمجيات – الذكاء الاصطناعي- النظم الذكية- النظم الخبيرة- معالجة الصور- معالجة اللغات الطبيعية – نظم الوكلاء المتعددة – نظم قواعد المعرفة – المعالجة على التوازي والنظم الموزعة – الحوسبة الشبكية والسحابية- نظم التعليم الذكية – تعليم الحاسبات – التعرف على النماذج – طرق اتصال الانسان بالحاسب – الرؤية بالحاسب – نظم الرسم بالحاسب- تعريب الحاسبات – برمجة التطبيقات.''',
                          context: context
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight, // العنصر الثالث على اليمين
                      child:  _buildDepartmentCard(imagePath: 'assets/images/is.png',
                          title: 'قسم نظم المعلومات IS',
                          description: '''يهتم القسم بتدريس وإجراء البحوث المتعلقة بالموضوعات والتخصصات العلمية التالية:أساسيات ومفاهيم لغات الحاسب ومترجماتها – لغة البرمجة – هياكل البيانات – تحليل وتصميم الخوارزميات – نظم تشغيل الحاسبات – بنية وتنظيم الحاسبات- تشفير البيانات وامن الحاسب – ضغط البيانات- هندسة البرمجيات – الذكاء الاصطناعي- النظم الذكية- النظم الخبيرة- معالجة الصور- معالجة اللغات الطبيعية – نظم الوكلاء المتعددة – نظم قواعد المعرفة – المعالجة على التوازي والنظم الموزعة – الحوسبة الشبكية والسحابية- نظم التعليم الذكية – تعليم الحاسبات – التعرف على النماذج – طرق اتصال الانسان بالحاسب – الرؤية بالحاسب – نظم الرسم بالحاسب- تعريب الحاسبات – برمجة التطبيقات.''',
                          context: context
                      ),
                    ),
                  ],
                ),
              ],
            )

          ),
        ),
      ),
    );



  }


  Widget _buildDepartmentCard({
    required BuildContext context,  // ✅ تمرير الـ context هنا
    required String imagePath,
    required String title,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DepartmentDetails(
              imagePath: imagePath,
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 198.sp,
            height: 210.sp,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.r),
                topLeft: Radius.circular(5.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: MyColors.blackColor.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.r),
                    topLeft: Radius.circular(5.r),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 198.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: MyColors.softBlackColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    description.replaceAll('\n', ' '),
                    style: TextStyle(
                      height: 1.5,
                      color: MyColors.softBlackColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 135.h,
            right: 155.w,
            child: SvgPicture.asset('assets/images/circle.svg'),
          ),
        ],
      ),
    );
  }



}

