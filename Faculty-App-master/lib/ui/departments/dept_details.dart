import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:faculty/utils/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class DepartmentDetails extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;


  const DepartmentDetails({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> professors = [
      {
        "name": "د/ ولاء محمد السيد",
        "image": "assets/images/professor.png",
      },
      {
        "name": "د/ ولاء محمد السيد",
        "image": "assets/images/professor.png",
      },
      {
        "name": "د/ ولاء محمد السيد",
        "image": "assets/images/professor.png",
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0, // منع تغير اللون عند التمرير
          leading: GestureDetector(
            onTap: (){
              if (ModalRoute.of(context)?.settings.name == Department.routeName) {
                Navigator.pushNamed(context, HomePage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
              child: Icon(Icons.arrow_back)),
        ),
        body:
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.sp,right: 30.sp,left: 30.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نبذة عن $title',
                          style: TextStyle(
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: MyColors.yellowColor),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: MyColors.yellowColor.withOpacity(0.2),
                            //     blurRadius: 16.r,
                            //     offset: Offset(4,2),
                            //   ),
                            // ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.r),
                                  topLeft: Radius.circular(16.r),
                                ),
                                child: Image.asset(
                                  imagePath,
                                  width: double.infinity,
                                  height: 200.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Text(
                                  description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: MyColors.softBlackColor,
                                    height: 2.h,
                                    fontSize: 10.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Center(
                          child: Text(
                            'الرؤية و الرسالة',
                            style: TextStyle(
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        _buildInfoContainer('رؤية و تخطيط', '''أساسيات ومفاهيم لغات الحاسب ومترجماتها – لغة البرمجة – هياكل البيانات – تحليل وتصميم الخوارزميات – نظم تشغيل الحاسبات – بنية و تنظيم الحاسبات- تشفير البيانات وامن الحاسب – ضغط البيانات- هندسة البرمجيات – الذكاء الاصطناعي- النظم الذكية- النظم الخبيرة- معالجة الصور- معالجة اللغات الطبيعية – نظم الوكلاء المتعددة – نظم قواعد المعرفة – المعالجة على التوازي والنظم الموزعة – الحوسبة الشبكية والسحابية- نظم التعليم الذكية – تعليم الحاسبات – التعرف على النماذج – طرق اتصال الانسان بالحاسب – الرؤية بالحاسب – نظم الرسم بالحاسب- تعريب الحاسبات – برمجة التطبيقات.'''),
                        SizedBox(height: 30.h),
                        _buildInfoContainer('رسالة القسم', 'أساسيات ومفاهيم لغات الحاسب ومترجماتها – لغة البرمجة – هياكل البيانات – تحليل وتصميم الخوارزميات – نظم تشغيل الحاسبات – بنية و تنظيم الحاسبات- تشفير البيانات وامن الحاسب – ضغط البيانات- هندسة البرمجيات – الذكاء الاصطناعي- النظم الذكية- النظم الخبيرة- معالجة الصور- معالجة اللغات الطبيعية – نظم الوكلاء المتعددة – نظم قواعد المعرفة – المعالجة على التوازي والنظم الموزعة – الحوسبة الشبكية والسحابية- نظم التعليم الذكية – تعليم الحاسبات – التعرف على النماذج – طرق اتصال الانسان بالحاسب – الرؤية بالحاسب – نظم الرسم بالحاسب- تعريب الحاسبات – برمجة التطبيقات.'),
                        SizedBox(height: 40.h),
                        Text(
                          'أعضاء هيئة التدريس',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 15.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'مدرس :',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildProfessorsList(professors),
                        Text(
                          'مدرس مساعد :',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildProfessorsList(professors),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 70.h,
                  right: 310.w,
                  child: Image.asset('assets/images/white_circle.png')),
              Positioned(
                  top: 57.h,
                  right: 300.w,
                  child: Image.asset('assets/images/Chain.png')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: MyColors.yellowColor,
                fontFamily: "Noto Kufi Arabic",
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 2.sp,
                color: MyColors.softBlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 8.sp,
                fontFamily: "Noto Kufi Arabic",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessorsList(List<Map<String, String>> professors) {
    return SizedBox(
      width: 310.w,
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: professors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(professors[index]["image"]!,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  professors[index]["name"]!,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
            Stack(
              alignment: Alignment.center,
              children: [
                // الـ Container الأساسي بالخلفية الصفراء
                Container(
                  width: 90.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: MyColors.softYellowColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                // الحدود المنقطة فوق الـ Container مباشرةً
                DottedBorder(
                  color: MyColors.yellowColor, // لون النقاط
                  strokeWidth: 2, // سمك النقاط
                  dashPattern: [6, 7], // طول النقطة والمسافة بين النقاط
                  borderType: BorderType.RRect, // يجعل الزوايا دائرية
                  radius: Radius.circular(10.r), // تدوير الزوايا
                  padding: EdgeInsets.zero, // بدون حشوات داخلية
                  child: Container(
                    width: 90.w,
                    height: 30.h,
                    color: Colors.transparent, // بدون لون داخلي
                    alignment: Alignment.center,
                    child: Text(
                      "سيرة ذاتية",
                      style: TextStyle(
                          color: MyColors.yellowColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Noto Kufi Arabic"
                      ),
                    ),
                  ),
                ),
            ]
          )

              ],
            ),
          );
        },
      ),
    );
  }
}



