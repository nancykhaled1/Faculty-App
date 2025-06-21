import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/home.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../auth/authProvider.dart';
import 'cubit/notificationviewmodel.dart';
import 'cubit/states.dart';
import 'notification_card.dart';

class NotificationScreen extends StatelessWidget{
  static const String routeName = 'notification';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.token == null) {
      // عرض AppBar + صورة
      return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icon.svg',
                width: 238,
                height: 238,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('لا يوجد اشعارات',
              style: TextStyle(
                color: MyColors.greyColor,
                fontFamily: "Noto Kufi Arabic",
                fontWeight: FontWeight.w500,
                fontSize: 24.sp ,
              ),
              )
            ],
          ),
        ),
        
      );
    }


    return BlocProvider(
      create: (_) => NotificationScreenViewModel(
        getNotificationUseCase: injectNotificationUseCase(),
      )..getNotification(authProvider.token!),

      child: BlocBuilder<NotificationScreenViewModel, NotificationStates>(
          builder: (context, state) {
            final viewModel = context.read<NotificationScreenViewModel>();
            if (state is NotificationLoadingStates) {
              return Scaffold(
                backgroundColor: MyColors.backgroundColor,
                body: const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                ),
              );
            }
            if (state is NotificationErrorStates) {
              return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
            }

            return SafeArea(
              child: Scaffold(
                  backgroundColor: MyColors.backgroundColor,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    scrolledUnderElevation: 0, // منع تغير اللون عند التمرير
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, HomePage.routeName);
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  body: ListView.builder(
                    itemCount: viewModel.notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(notification: viewModel.notifications[index]);
                    },
                  )

              ),
      
            );
          }
      ),
    );
  }

}