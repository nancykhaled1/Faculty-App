import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:faculty/ui/home/newsModel.dart'; // تأكد من استيراد NewsModel
import 'package:faculty/ui/home/homescreen.dart'; // تأكد من استيراد الصفحة الرئيسية
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Newsdetails extends StatefulWidget {
  final News news; // استقبال خبر واحد فقط عبر الـ constructor.

  const Newsdetails({super.key, required this.news}); // استقبال الخبر المحدد

  @override
  State<Newsdetails> createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 45, right: 33),
        child: SingleChildScrollView(
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
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: SvgPicture.asset(
                      widget.news.image, // استخدام صورة الخبر المحدد
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SvgPicture.asset(
                widget.news.image, // استخدام صورة الخبر المحدد
                width: 342.w,
                height: 255.h,
              ),
              SizedBox(height: 30.h),
              Text(
                widget.news.title, // استخدام العنوان من الخبر المحدد
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Noto Kufi Arabic",
                  color: MyColors.primaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.news.content, // عرض المحتوى الكامل من الخبر المحدد
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Kufi Arabic",
                  color: MyColors.softBlackColor,
                  height: 2.h,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                softWrap: true,
              ),
              SizedBox(height: 40.h),
              // إذا كان لديك قائمة أخرى من الأخبار، يمكنك التعامل معها هنا
              // وإذا كانت الأخبار موجودة في `widget.newsList` فيجب تمريرها بشكل صحيح.
              // إذا كنت لا تحتاج إلى `newsList` في هذا الجزء، يمكنك إزالته.
             SizedBox(
              height: 137.h,
               child: ListView.builder(
                itemCount: 3,
                       scrollDirection: Axis.horizontal,
               
                          itemBuilder: (context, index) {
                       
               
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SvgPicture.asset(
                       widget.news.image, // استخدام الصورة الخاصة بالخبر
                       width: 147.w, // عرض الصورة
                       height: 152.h, // ارتفاع الصورة
                       fit: BoxFit.cover,
                     ),
                   );
                 },
               ),
             ),            ],
          ),
        ),
      ),
    );
  }
}
