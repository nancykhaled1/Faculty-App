import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Team2 extends StatefulWidget {
  const Team2({super.key});

  @override
  State<Team2> createState() => _Team1State();
}

class _Team1State extends State<Team2> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                          MaterialPageRoute(
                            builder: (context) => AcademicTeams(),
                          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Text(
                        " الفرقة الثانية",
                        style: TextStyle(
                          fontFamily: "Noto Kufi Arabic",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: MyColors.softBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    "جدول الفرقة الدراسية للفصل الدراسي الأول - العام الأكاديمي 2024/2025 ",

                    style: TextStyle(
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                GestureDetector(
                  onTap: (){},
                  child: Text(
                    "جدول امتحانات الشفوي للفصل الدراسي الأول للعام الأكاديمي 2024/2025",

                    style: TextStyle(
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                GestureDetector(
                  onTap: (){},
                  child: Text(
                    "جدول امتحانات العملي للفصل الدراسي الأول للعام الأكاديمي 2024/2025",

                    style: TextStyle(
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                GestureDetector(
                  onTap: (){},
                  child: Text(
                    "أرقام جلوس المستوى الثانى",

                    style: TextStyle(
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}