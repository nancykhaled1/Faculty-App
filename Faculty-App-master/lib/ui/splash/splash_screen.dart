
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';

import '../onboarding/onboarding.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 1), () {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoarding()),
        );
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColors.primaryColor, MyColors.secondryColor], // الألوان
            begin: Alignment.topCenter, // بداية التدرج (أعلى)
            end: Alignment.bottomCenter, // نهاية التدرج (أسفل)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع المسافات بشكل متساوٍ
          children: [
            const Spacer(), // يترك مساحة فارغة في الأعلى
            Center(
              child: Image.asset(
                "assets/images/log.png",
                width: 117,
                height: 127,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(), // يترك مساحة فارغة قبل الصورة السفلية
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/Component.png",

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}