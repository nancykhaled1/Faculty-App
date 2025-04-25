import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';

class ScholarshipsScreen extends StatefulWidget {
  static const String routeName = 'scholarship';

  @override
  State<ScholarshipsScreen> createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  final List<Map<String, String>> items = [
    {
      "image": "assets/images/it.png",
      "text": "تفاصيل منحة دراسية مقدمة من الجامعة الأمريكية"
    },
    {
      "image": "assets/images/it.png",
      "text": "منحة دراسية في ألمانيا تشمل السكن والمصاريف"
    },
    {
      "image": "assets/images/doctors.png",
      "text": "فرصة تبادل طلابي مع جامعة في تركيا"
    },
    {
      "image": "assets/images/doctors.png",
      "text": "فرصة تبادل طلابي مع جامعة في تركيا"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 زر الرجوع
              Padding(
                padding: EdgeInsets.only(top: 10.h, right: 20.w, bottom: 5.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/icons/backarrow.svg",
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
              // SizedBox(height: 30.h),
              /// 🔹 ليستة الصور والنصوص
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item['image']!,
                          width: double.infinity,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          item['text']!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Noto Kufi Arabic",
                            color: MyColors.softBlackColor,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                        Divider(thickness: 1, color: Colors.grey.shade300), // فاصل بين العناصر
                      ],
                    ),
                  );
                },
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}
