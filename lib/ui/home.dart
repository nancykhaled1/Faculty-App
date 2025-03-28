import 'package:faculty/ui/auth/auth.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home/homescreen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    Center(child: Text('الطلاب', style: TextStyle(fontSize: 20, fontFamily: "Noto Kufi Arabic"))),
  ];

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
        body: isAuthScreen ? AuthScreen() :
        Column(
          children: [
            // 🔹 شريط البحث في أعلى الصفحة
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
            // 🔹 المساحة الرئيسية للصفحات
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),

        // 🔹 شريط التنقل السفلي (إخفاؤه إذا كانت الصفحة هي AuthScreen)
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