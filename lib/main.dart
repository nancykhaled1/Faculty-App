

import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/alumni/cubit/profileviewmodel.dart';
import 'package:faculty/ui/alumni/profile_notemploee.dart';
import 'package:faculty/ui/alumni/profilescreen.dart';
import 'package:faculty/ui/auth/authProvider.dart';
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
import 'package:faculty/ui/students/cubit/studentviewmodel.dart';
import 'package:faculty/ui/students/scholarships-screen.dart';
import 'package:faculty/ui/students/student-activity-screen.dart';
import 'package:faculty/ui/students/student_screen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'data/local/preferences.dart';
import 'domain/usecase/di.dart';
import 'domain/usecase/get_userdata_usecase.dart';
import 'ui/auth/auth_alumni.dart';

Future<void> main() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // مهم جداً لتهيئة القنوات قبل استخدام async

    await SharedPrefsHelper.init(); // تهيئة SharedPreferences
    final authProvider = AuthProvider();
    await authProvider.loadUserDataFromPrefs();



    runApp(
    MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (_) => StudentViewModel()),
        BlocProvider<ProfileViewModel>(
          create: (_) => ProfileViewModel(getUserdataUseCase: injectGetUserDataServiceUseCase(), updateDataUseCase: injectUpdateDataUseCase()), // مرري الـ use case المناسب هنا
        ),
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
        ),


        // ممكن تزود providers تانين هنا
      ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    Map<String, String?> data = await SharedPrefsHelper.getUserData();
    print('User Datajasdasg: $data');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: MyColors.primaryColor
            ),

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


            initialRoute: SplashScreen.routeName,
            routes: {
            //  Register.routeName : (context) => Register(),
              AlumniAuthScreen.routeName : (context) => AlumniAuthScreen(),
              SuccessScreen.routeName : (context) => SuccessScreen(userType: '',),
              LoginScreen.routeName : (context) => LoginScreen(userType: '',),
              ForgetPassScreen.routeName : (context) => ForgetPassScreen(),
              SendCode.routeName : (context) => SendCode(),
              RePassword.routeName : (context) => RePassword(),
              Department.routeName : (context) => Department(),
              HomePage.routeName : (context) => HomePage(),
              SplashScreen.routeName : (context) => SplashScreen(),
              UserProfileScreen.routeName : (context) => UserProfileScreen(),
              StudentScreen.routeName : (context) => StudentScreen(),
              NotificationScreen.routeName : (context) => NotificationScreen(),
              Complaint.routeName: (context) => Complaint(),
              ScholarshipsScreen.routeName : (context) => ScholarshipsScreen(),
              StudentActivityScreen.routeName : (context) => StudentActivityScreen(),
              //ProfileScreen.routeName : (context) => ProfileScreen(),
              AcademicTeams.routeName: (context) => AcademicTeams(),

            },
          );

      }

// فرح وجيه
 );
  }
}



