import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/students/cubit/studentportalviewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';
import 'cubit/states.dart';

class ScholarshipsScreen extends StatefulWidget {
  static const String routeName = 'scholarship';

  @override
  State<ScholarshipsScreen> createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentPortalViewModel(getStudentPortalUseCase: injectGetStudentPortalUseCase())..getStudentPortal(),
      child: BlocBuilder<StudentPortalViewModel,StudentStates>(
          builder: (context,state){
              final viewModel = BlocProvider.of<StudentPortalViewModel>(context);
              return SafeArea(
                child: Scaffold(
                  backgroundColor: MyColors.backgroundColor,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, right: 20.w, bottom: 10.h,left: 40.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/backarrow.svg",
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                        if (state is StudentLoadingStates)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 300.h),
                              child: CircularProgressIndicator(color: MyColors.primaryColor),
                            ),
                          )
                        else if (state is StudentErrorStates)
                          Center(
                            child: Text(state.errorMessage ?? '', style: TextStyle(color: Colors.red)),
                          )
                        else if (state is StudentPortalSuccessStates)
                           ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: viewModel.scholarShip.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.scholarShip[index];
                            final DateTime parsedDate = DateTime.parse(item.createdAt ??'').toLocal();
                            final String formattedDate = DateFormat('HH:mm – dd/MM/yyyy').format(parsedDate);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    item.image ?? '',
                                    width: double.infinity,
                                    height: 170.h,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    item.title ??'',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Noto Kufi Arabic",
                                      color: MyColors.softBlackColor,
                                    ),
                                   // textDirection: TextDirection.rtl,
                                    //textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    item.content ??'',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Noto Kufi Arabic",
                                      color: MyColors.softBlackColor,
                                    ),
                                   // textDirection: TextDirection.rtl,
                                   // textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () async {
                                      if (item.link != null && item.link!.isNotEmpty) {
                                        launchUrl(Uri.parse(item.link!));
                                      }else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('لا يمكن فتح الرابط')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'للتقديم ومعرفة المزيد من التفاصيل، اضغط هنا: [أدخل الرابط هنا]',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Noto Kufi Arabic",
                                        color: MyColors.primaryColor,
                                      ),
                                     // textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Noto Kufi Arabic",
                                        color: MyColors.greyColor,
                                      ),
                                      // textDirection: TextDirection.rtl,
                                      // textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Divider(thickness: 1, color: Colors.grey.shade300),
                                ],
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              );

          }
      ),
    );

  }
}
