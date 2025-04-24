import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Team1 extends StatefulWidget {
  const Team1({super.key});

  @override
  State<Team1> createState() => _Team1State();
}

class _Team1State extends State<Team1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.only(top: 45, right: 33),
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
                        MaterialPageRoute(builder: (context) => AcademicTeams()),
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
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(" الفرقة الأولى",style: TextStyle(fontFamily: "Noto Kufi Arabic",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.softBlackColor,
                    
                    ),),
                  )
                ],
              ),

SizedBox(height: 26.h,),
Text("جدول الفرقة الدراسية للفصل الدراسي الأول - العام الأكاديمي 2024/2025 ",

style: TextStyle(fontFamily: "Noto Kufi Arabic",
fontSize: 13.sp,
fontWeight: FontWeight.w500,
color: MyColors.primaryColor,

),
),
SizedBox(height: 36.h,),
Padding(
  padding: const EdgeInsets.only(right: 25,left: 25),
  child: Divider(
                    color: Color(0XFFD4D4D4),
                    thickness: 1,
                    height: 20,
                  ),
),
SizedBox(height: 36.h,),

Text("جدول امتحانات الشفوي للفصل الدراسي الأول للعام الأكاديمي 2024/2025",

style: TextStyle(fontFamily: "Noto Kufi Arabic",
fontSize: 13.sp,
fontWeight: FontWeight.w500,
color: MyColors.primaryColor,

),
),
SizedBox(height: 36.h,),
Padding(
  padding: const EdgeInsets.only(right: 25,left: 25),
  child: Divider(
                    color: Color(0XFFD4D4D4),
                    thickness: 1,
                    height: 20,
                  ),
),
SizedBox(height: 36.h,),

Text("جدول امتحانات العملي للفصل الدراسي الأول للعام الأكاديمي 2024/2025",

style: TextStyle(fontFamily: "Noto Kufi Arabic",
fontSize: 13.sp,
fontWeight: FontWeight.w500,
color: MyColors.primaryColor,

),
),
SizedBox(height: 36.h,),
Padding(
  padding: const EdgeInsets.only(right: 25,left: 25),
  child: Divider(
                    color: Color(0XFFD4D4D4),
                    thickness: 1,
                    height: 20,
                  ),
),
SizedBox(height: 36.h,),

Text("أرقام جلوس المستوى الأول",

style: TextStyle(fontFamily: "Noto Kufi Arabic",
fontSize: 13.sp,
fontWeight: FontWeight.w500,
color: MyColors.primaryColor,

),
),
SizedBox(height: 36.h,),
Padding(
  padding: const EdgeInsets.only(right: 25,left: 25),
  child: Divider(
                    color: Color(0XFFD4D4D4),
                    thickness: 1,
                    height: 20,
                  ),
),


            ]
          )
        ) 
        )
    );
  }
}