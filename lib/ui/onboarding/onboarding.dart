
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnBoardingDate> onboarding = [
    OnBoardingDate(
        title: "خليك على اطلاع",
        description: "احدث أخبار الكلية دايمًا عندك و في مكان واحد",
        image: "assets/images/onboarding3.png"),
    OnBoardingDate(
        title: "جدولك في ايدك",
        description: "اعرف مواعيد محاضراتك وامتحاناتك بسهولة في أي وقت",
        image: "assets/images/onboarding2.png"),
    OnBoardingDate(
        title: "سجل إنجازاتك",
        description: "عرض خبراتك وشهاداتك في مكان واحد",
        image: "assets/images/onboarding3.png")
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Column(
          children: [
            // زر التخطي في الأعلى
            topPageView(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboarding.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            onboarding[index].image,
                            width: double.infinity,
                            height: 650,
                          ),
                          Positioned(
                            top: 400.h,
                            right:20.w,
                            left:20.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    onboarding[index].title,
                                    style:  TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Noto Kufi Arabic"),
                                  ),
                                   SizedBox(height: 10.h),
                                  Padding(
                                    padding:  EdgeInsets.only(right: 20, left: 20),
                                    child: Text(
                                      onboarding[index].description,
                                      textAlign: TextAlign.center,
                                      style:  TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: "Noto Kufi Arabic",fontWeight:FontWeight.w500 ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )

                        ],
                      )



                    ],
                  );
                },
              ),
            ),
            // المؤشر وزرار التالي
            bottomPageView(),
          ],
        ),
      ),
    );
  }

  Widget topPageView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {
            if (_currentIndex < onboarding.length - 1) {
              _pageController.animateToPage(
                _currentIndex + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          child: const Text(
            "تخطي",
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }


  Widget bottomPageView() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () {
            if (_currentIndex < onboarding.length - 1) {
              _pageController.animateToPage(
                _currentIndex + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          child: Container(
            width: 125,
            height: 30,
            decoration: BoxDecoration(
              color: MyColors.primaryColor, // لون الزر الأساسي
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: _currentIndex == onboarding.length - 1
                  ? Text(
                "ابدأ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Kufi Arabic",
                ),
              )
                  : Container(

                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor, // لون الزر الأساسي
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class OnBoardingDate{

  final  String  title ;
  final  String  description ;
  final  String  image ;

  OnBoardingDate({required this.title, required this.description, required this.image});



}