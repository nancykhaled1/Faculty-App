import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:faculty/ui/home/newsModel.dart'; // تأكد من استيراد NewsModel
import 'package:faculty/ui/home/homescreen.dart'; // تأكد من استيراد الصفحة الرئيسية
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Newsdetails extends StatefulWidget {
  final News news; // استقبال الكائن News

  const Newsdetails({super.key, required this.news}); // تمرير الكائن عبر الـ constructor

  @override
  State<Newsdetails> createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  @override
  Widget build(BuildContext context) {
    final news = widget.news; // الوصول إلى الكائن news الذي تم تمريره عبر الـ constructor

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
                      "assets/images/Upload.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SvgPicture.asset(
       news.image,
  width: 342.w,
  height: 255.h,
),

              SizedBox(height: 30.h),
              Text(
                news.title, // استخدام المتغير `news` هنا
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500,fontFamily: "Noto Kufi Arabic",
                color: MyColors.primaryColor,
                
                
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                news.content, // عرض المحتوى الكامل
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400,fontFamily: "Noto Kufi Arabic",
                color: MyColors.softBlackColor,
                height: 2.h
              ),
              textAlign: TextAlign.right,
  textDirection: TextDirection.rtl,
  softWrap: true,

              ) ,
              SizedBox(height: 40.h,),
//               ListView.builder(
//         itemCount:3, // عدد العناصر في القائمة
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SvgPicture.asset(
// "assets/images/newsDetails.svg",
//               width: 147.w, // عرض الصورة
//               height: 152.h, // ارتفاع الصورة
//               fit: BoxFit.cover, 
//             ),
//           );
//         },
//       ),
            ],
            
          ),
        ),
      ),
    );
  }
}
