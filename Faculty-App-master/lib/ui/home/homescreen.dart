import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView( // جعل الصفحة قابلة للتمرير
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 الصورة الكبيرة
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/Rectangle 40.png",
                  width: 342.w,
                  height: 242.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 قسم "الرؤية والرسالة"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Group 65.svg",),
                       Text(
                        "الرؤية و الرسالة",
                        style: TextStyle(
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),

                      SizedBox(width: 5),

                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 🔹 قسم "الرؤية والتخطيط"
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "الرؤية والتخطيط",
                          style: TextStyle(
                            height: 1.h,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                            fontSize: 8.sp,
                            color: MyColors.yellowColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              flex: 2,
                              child: Text(
                                "تسعى كلية الحاسبات والمعلومات - جامعة دمنهور إلى التميز والريادة والإبتكار في مجالات التعليم والبحث العلمي، وخدمة المجتمع على المستوى المحلي والإقليمي والعالمي.",
                                style: TextStyle(
                                  color: MyColors.softBlackColor,
                                  height: 2.h,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 6.sp,
                                ),
                                textAlign: TextAlign.right,
                                softWrap: true, // يسمح بكسر النص عند الحاجة
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/vision.svg",
                              // width: 80.w, // تقليل حجم الصورة لحل المشكلة
                              // height: 80.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 10.w),

                          ],
                        ),

                       // SizedBox(height: 10.h),
                      ],
                    ),

                  ),

                  SizedBox(height: 35.h),
                  // 🔹 قسم "رسالة الكلية"
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "رسالة الكلية",
                          style: TextStyle(

                              height: 1.h,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                              fontSize: 8.sp,
                              color: MyColors.yellowColor
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [

                            Expanded(
                              flex: 2,
                              child: Text("إعداد خريجين متميزين في مجالات الحاسب الآلي ونظم وتكنولوجيا المعلومات وفقا لمتطلبات سوق العمل، وطبقا للمواصفات العالمية، وتعزيز الاستفادة من نتائج البحث العلمي في مجالات الحاسب الآلي ونظم وتكنولوجيا المعلومات بما يحقق مردود مجتمعي إيجابي وتقديم خدمات مميزة للمجتمع وفق المجالات المتاحة بالكلية"

                                ,  style: TextStyle(
                                  color: MyColors.softBlackColor,
                                  height: 2.h,

                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 6.sp,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/message.svg",
                              // width: 100.w,
                              // height: 100.h,
                            ),
                          ],
                        ),
                      //  SizedBox(height: 10.h),

                      ],
                    ),
                  ),

                  // Image.asset("assets/Line 63.png",width: 342.w,height: 0.h,),
                ],
              ),
            ),

            SizedBox(height: 15.h,),
            SizedBox(
              width: 342.w, // تحديد العرض المطلوب
              child: Divider(
                color:  Color(0XFFD4D4D4), // لون الخط
                thickness: 1, // سمك الخط
                height: 20, // المسافة حول الخط
              ),
            ),
            SizedBox(height: 35.h,),
            // 🔹 "أحدث الفعاليات والأخبار"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أحدث الفعاليات والأخبار",
                  style: TextStyle(
                    color: MyColors.softBlackColor,
                    fontSize: 15.sp,
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 35.h),

            // 🔹 قائمة الأخبار بشكل أفقي
            SizedBox(
              height: 240.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 147.w,
                  //  height: 150.h,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.asset(
                            "assets/images/doctors.png",
                            width: 147.w,
                            height: 109.h,

                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "زيارة معالى رئيس جامعة دمنهور لكلية الحاسبات والمعلومات بالنوبارية",
                                style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 8.sp,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w500,

                                ),
                                textAlign: TextAlign.right,
                              ),
                              //  SizedBox(height: 15),

                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0XFFD4D4D4), // لون الخط
                                thickness: 1, // سمك الخط
                                // height: 20, // المسافة حول الخط
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "17 Oct, 2024",
                                    style: TextStyle(fontSize: 7.sp, color:MyColors.greyColor,fontFamily: "Noto Kufi Arabic",
                                      fontWeight: FontWeight.w500,),
                                    textAlign: TextAlign.left,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: MyColors.yellowColor, width: 1), // لون الحدود أصفر
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15), // تدوير الحواف
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2), // تعديل الحواف الداخلية
                                    ),
                                    child:  Text(
                                      "التفاصيل",
                                      style: TextStyle(color: MyColors.yellowColor),
                                    ),
                                  ),


                                ],
                              ),


                            ],
                          ),

                        ),

                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        ),

      ),



    );
  }
}