import 'package:faculty/ui/Academic_teams/team1.dart';
import 'package:faculty/ui/Academic_teams/team2.dart';
import 'package:faculty/ui/Academic_teams/team3.dart';
import 'package:faculty/ui/Academic_teams/team4.dart';
import 'package:faculty/ui/home.dart';
import 'package:faculty/ui/home/homescreen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AcademicTeams extends StatefulWidget {
  static const String routeName = 'academicTeams';
  const AcademicTeams({super.key});

  @override
  State<AcademicTeams> createState() => _AcademicTeamsState();
}

class _AcademicTeamsState extends State<AcademicTeams> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
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
                    Text(
                      "الفرق الدراسية",
                      style: TextStyle(
                        fontFamily: "Noto Kufi Arabic",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.softBlackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Team1()),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/images/groub1.svg",
                      width: 348.w,
                      height: 96.5.h,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Team2()),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/images/groub2.svg",
                      width: 348.w,
                      height: 96.5.h,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Team3()),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/images/groub3.svg",
                      width: 348.w,
                      height: 96.5.h,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Team4()),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/images/groub4.svg",
                      width: 348.w,
                      height: 96.5.h,
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
