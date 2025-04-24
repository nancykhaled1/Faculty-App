import 'package:faculty/ui/auth/auth.dart';
import 'package:faculty/ui/complaint/complaint.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home/homescreen.dart';
import 'package:faculty/ui/students/student_screen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    Department(),
    AuthScreen(),
    StudentScreen(),
  ];
  bool _isExpanded = false;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAuthScreen = _pages[_selectedIndex] is AuthScreen; // تحقق إذا كانت الصفحة الحالية هي AuthScreen

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Stack(
          children: [
            // 🔹 المحتوى الأساسي
            Column(
              children: [
                if (!isAuthScreen)
                  Padding(
                    padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 20.h, bottom: 5.h),
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
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Icon(Icons.search, color: MyColors.greyColor),
                          ),
                          hintText: 'ادخل كلمة البحث',
                          hintStyle: TextStyle(
                            color: MyColors.greyColor,
                            fontFamily: "Noto Kufi Arabic",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        ),
                      ),
                    ),
                  ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),

            // ✅ الأيقونة الزرقا الثابتة
            if (!isAuthScreen)
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: GestureDetector(
                  onTap: () {
                    if (_isExpanded) {
                      // ✅ لو كانت مفتوحة، ننتقل للصفحة
                      Navigator.pushReplacementNamed(context, Complaint.routeName); // لازم تضيفي المسار دا في routes
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
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                          child: _isExpanded
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

        // 🔹 الـ BottomNavigationBar
        bottomNavigationBar: isAuthScreen
            ? null
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
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
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
                  BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'الأقسام'),
                  BottomNavigationBarItem(icon: Icon(Icons.school), label: 'الخريجين'),
                  BottomNavigationBarItem(icon: Icon(Icons.people), label: 'الطلاب'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }}