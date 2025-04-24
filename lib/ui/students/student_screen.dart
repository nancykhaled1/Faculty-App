import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ElectronicServicesBody.dart';
import 'StudentLifeBody.dart';
import 'StudyLifeBody.dart';

class StudentScreen extends StatefulWidget{
  static const String routeName = 'student';

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<String> categories = ["حياة دراسية", "خدمات الكترونية", "حياة طلابية"];
  String selectedType = "حياة دراسية";
  int selectedIndex = 0;

  List<String> categoryIcons = [
    'assets/icons/Community Students.svg',
    'assets/icons/electronicService.svg',
    'assets/icons/Life_Insurance.svg',

  ];
  final List<Widget> screens = [
    StudyLifeBody(),
    ElectronicServicesBody(),
    StudentLifeBody(),
  ];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          if (selectedIndex != index) { // تأكد من التحديث فقط عند اختلاف الفئة
                            setState(() {
                              selectedIndex = index;
                              selectedType = categories[index].toLowerCase();

                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? MyColors.backgroundColor : Colors.white,
                            borderRadius: BorderRadius.circular(7.r),
                            border: Border.all(
                              color: isSelected ? MyColors.yellowColor : Colors.transparent,
                            //  width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                categoryIcons[index],
                              //  width: 30.w,
                              //  height: 30.h,
                                color: isSelected ? MyColors.yellowColor : MyColors.blackColor,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                categories[index],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                  color: isSelected ? MyColors.yellowColor : MyColors.blackColor,
                                ),
                              ),
                            ],
                          )

                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: screens[selectedIndex]),
              ],
                  ),
          ),
    ));
  }
}