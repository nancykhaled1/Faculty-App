import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_cubit.dart';
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
import 'package:faculty/ui/home/cubit/states/news_cubit.dart';
import 'package:faculty/ui/home/cubit/states/faculty_info_cubit.dart';
import 'package:faculty/ui/notification/notification_screen.dart';
import 'package:faculty/ui/splash/splash_screen.dart';
import 'package:faculty/ui/students/scholarships-screen.dart';
import 'package:faculty/ui/students/student-activity-screen.dart';
import 'package:faculty/ui/students/student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:faculty/ui/home/cubit/states/vision_mission_cubit.dart';
import 'ui/auth/auth_alumni.dart';
import 'package:faculty/ui/complaint/cubit/send_complaint_cubit.dart';
import 'package:faculty/domain/usecases/send_complaint_usecase.dart';
import 'package:faculty/data/remote/api/complaint_remote_data_source.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        BlocProvider(create: (_) => VisionMissionCubit()),
        BlocProvider(create: (_) => NewsCubit()..getNews()),
        BlocProvider(create: (_) => AcademicTeamsCubit()),
        BlocProvider(create: (_) => FacultyInfoCubit()),
        BlocProvider(
          create: (_) => SendComplaintCubit(
            SendComplaintUseCase(ComplaintRemoteDataSource()),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
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


            initialRoute: SplashScreen.routeName,
            routes: {
              Register.routeName : (context) => Register(),
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
              ProfileScreen.routeName : (context) => ProfileScreen(),
              AcademicTeams.routeName: (context) => AcademicTeams(),
              StudentScreen.routeName : (context) => StudentScreen(),
              NotificationScreen.routeName : (context) => NotificationScreen(),
              Complaint.routeName: (context) => Complaint(),

            },
          );
      
      }
    
// فرح وجيه 
 );
  } 
  }



