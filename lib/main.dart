

import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/alumni/profilescreen.dart';
import 'package:faculty/ui/auth/login/forget_pass.dart';
import 'package:faculty/ui/auth/login/loginscreen.dart';
import 'package:faculty/ui/auth/login/re_pass.dart';
import 'package:faculty/ui/auth/login/send_code.dart';
import 'package:faculty/ui/auth/register/alumni_register.dart';
import 'package:faculty/ui/auth/register/success.dart';
import 'package:faculty/ui/complaint/complaint.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home.dart';

import 'package:faculty/ui/notification/notification_screen.dart';
import 'package:faculty/ui/splash/splash_screen.dart';
import 'package:faculty/ui/students/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ui/auth/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
          return MaterialApp(
            locale: Locale('ar', ''), // 👈 تحديد اللغة العربية لجعل كل شيء RTL
            supportedLocales: [
              Locale('ar', ''), // Arabic
              Locale('en', ''), // English (احتياطي)
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],


            initialRoute: HomePage.routeName,
            routes: {
              Register.routeName : (context) => Register(),
              AuthScreen.routeName : (context) => AuthScreen(),
              SuccessScreen.routeName : (context) => SuccessScreen(),
              LoginScreen.routeName : (context) => LoginScreen(),
              ForgetPassScreen.routeName : (context) => ForgetPassScreen(),
              SendCode.routeName : (context) => SendCode(),
              RePassword.routeName : (context) => RePassword(),
              Department.routeName : (context) => Department(),
              HomePage.routeName : (context) => HomePage(),
              SplashScreen.routeName : (context) => SplashScreen(),
              UserProfileScreen.routeName : (context) => UserProfileScreen(),

                  Complaint.routeName: (context) => Complaint(),
                  AcademicTeams.routeName: (context) => AcademicTeams(),
                    StudentScreen.routeName : (context) => StudentScreen(),
              NotificationScreen.routeName : (context) => NotificationScreen()
          

                 
            },
          );

            

            },
          );
    }
    

  }



