import 'package:faculty/ui/home.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';

import 'notification_card.dart';

class NotificationScreen extends StatelessWidget{
  static const String routeName = 'notification';

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, // منع تغير اللون عند التمرير
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          NotificationCard(
            message: 'عزيزي الخريج، تم إصدار شهادتك الرسمية. يُرجى التوجه إلى مكتب شؤون الخريجين لاستلامها.',
            date: '17 oct, 2024',
          ),
          NotificationCard(
            message: 'عزيزي الخريج، تم إصدار شهادتك الرسمية. يُرجى التوجه إلى مكتب شؤون الخريجين لاستلامها.',
            date: '17 oct, 2024',
          ),
          NotificationCard(
            message: 'عزيزي الخريج، تم إصدار شهادتك الرسمية. يُرجى التوجه إلى مكتب شؤون الخريجين لاستلامها.',
            date: '17 oct, 2024',
          ),
        ],
      ),

    ));
  }

}