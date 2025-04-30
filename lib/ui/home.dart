import 'package:faculty/colorManager.dart';
import 'package:faculty/ui/auth/auth_alumni.dart';
import 'package:faculty/ui/auth/auth_student.dart';
import 'package:faculty/ui/complaint/complaint.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home/homescreen.dart';
import 'package:faculty/ui/notification/notification_screen.dart';
import 'package:faculty/ui/students/ElectronicServicesBody.dart';
import 'package:faculty/ui/students/student_screen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'alumni/profile_notemploee.dart';
import 'alumni/profilescreen.dart';
import 'auth/authProvider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isUserLoggedIn = false;
  final List<Widget> _pages = [
    HomeScreen(),
    Department(),
    UserProfileScreen(),
    StudentScreen(),
  ];
  bool _isExpanded = false;

  void _onItemTapped(int index) {
    if (index == 2) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.isLoggedIn && authProvider.userType == "graduates") {
        setState(() {
          _selectedIndex = index;
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AlumniAuthScreen()),
        ).then((_) {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          if (authProvider.isLoggedIn && authProvider.userType == "graduates") {
            setState(() {
              _selectedIndex = index;
            });
          }
        });
      }
    }
    else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final userType = authProvider.userType;
    bool isAlumniPage = _selectedIndex == 2;
    bool isUserLoggedIn = authProvider.isLoggedIn;
    bool isProfileScreen = isAlumniPage && isUserLoggedIn;
    bool showIcons =  isUserLoggedIn; // لو داخل الخريجين ومسجل
    bool isAuthScreen = isAlumniPage && !isUserLoggedIn; // لو داخل الخريجين ومش مسجل

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Stack(
          children: [
            Column(
              children: [
                if (_selectedIndex != 2)
                // 🔵 السيرش بار
                Padding(
                  padding: EdgeInsets.only(
                    right: 30.w,
                    left: 30.w,
                    top: 20.h,
                    bottom: 5.h,
                  ),
                  child: Row(
                    children: [

                      // 🔵 صندوق البحث
                      Expanded(
                        child: Container(
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.blackColor.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                child: Icon(
                                  Icons.search,
                                  color: MyColors.greyColor,
                                ),
                              ),
                              hintText: 'ادخل كلمة البحث',
                              hintStyle: TextStyle(
                                color: MyColors.greyColor,
                                fontFamily: "Noto Kufi Arabic",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if(userType =="graduates") ...[
                      // 🔵 لو المفروض تظهر الأيقونات
                      if (showIcons) ...[
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 39.w,
                            height: 39.h,
                            decoration: BoxDecoration(
                              color: ColorManager.backgroundColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/icons/notification1.svg",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 39.w,
                            height: 39.h,
                            decoration: BoxDecoration(
                              color: ColorManager.backgroundColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Image.asset("assets/icons/profiles.png",
                            fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                      ],
                    ],
                  ),
                ),

                Expanded(child: _pages[_selectedIndex]),
              ],
            ),

            // باقي الكود كما هو: الأيقونة الزرقاء والثابتة (للطلبة)
            if (!isAuthScreen && !isProfileScreen)
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: GestureDetector(
                  onTap: () {
                    if (_isExpanded) {
                      // ✅ لو كانت مفتوحة، ننتقل للصفحة
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentAuthScreen(),
                        ),
                      );
                      // لازم تضيفي المسار دا في routes
                    } else {
                      // ✅ نفتح الأنيميشن أول مرة
                      setState(() {
                        _isExpanded = true;
                      });
                      // ❗️نخليها ترجع تلقائي بعد شوية لو ما دخلش
                      Future.delayed(Duration(seconds: 3), () {
                        if (mounted) {
                          setState(() {
                            _isExpanded = false;
                          });
                        }
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.secondryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        bottomLeft: Radius.circular(15.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Message.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (child, animation) => FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          child:
                          _isExpanded
                              ? Padding(
                            key: ValueKey('label'),
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              'الآراء والشكاوى',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Noto Kufi Arabic",
                              ),
                            ),
                          )
                              : SizedBox(key: ValueKey('empty')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),

        // 🔵 البوتوم بار
        bottomNavigationBar: (isAuthScreen || isProfileScreen) ? null : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: MyColors.yellowColor,
                unselectedItemColor: MyColors.blackColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'الرئيسية',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pie_chart),
                    label: 'الأقسام',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'الخريجين',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'الطلاب',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



