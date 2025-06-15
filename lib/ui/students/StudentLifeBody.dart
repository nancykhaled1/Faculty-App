import 'package:faculty/ui/students/student-activity-screen.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/studentEntity.dart';
import '../../domain/usecase/di.dart';
import 'cubit/states.dart';
import 'cubit/studentviewmodel.dart';

class StudentLifeBody extends StatefulWidget {

  final List<StudentResponseEntity> services;

  StudentLifeBody({required this.services});

  @override
  State<StudentLifeBody> createState() => _StudentLifeBodyState();
}

class _StudentLifeBodyState extends State<StudentLifeBody> {
  //
  late StudentViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StudentViewModel(getStudentServiceUseCase: injectGetStudentServiceUseCase()

    );
    viewModel.selectService(); // 🟢 هنا التصنيف
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentViewModel,StudentStates>(
      listener: (context,state){},
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 15.h),
          itemCount: widget.services.length,
          // padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            final item = widget.services[index];
            return ListTile(
              leading:Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h , vertical: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(color: MyColors.primaryColor),
                ),
                child: Image.network(
                  item.image??'',
                  width: 25,
                  height: 25,
                ),
              ),
              title: Text(item.name??'', style: TextStyle(
                  color: MyColors.softBlackColor,
                  fontFamily: "Noto Kufi Arabic",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500)),
              subtitle: Text(item.description??'',
                  style: TextStyle(
                      color: MyColors.greyColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500)),

              onTap: () {
                // final actionType = item['actionType'];
                // final data = item['data'];
                //
                // switch (actionType) {
                // // case 'pdf':
                // // // افتح ملف PDF
                // //   Navigator.push(
                // //     context,
                // //     MaterialPageRoute(
                // //       builder: (context) => PdfViewerScreen(pdfPath: data),
                // //     ),
                // //   );
                // //   break;
                // //
                // // case 'link':
                // // // افتح لينك في المتصفح
                // //   launchUrl(Uri.parse(data));
                // //   break;
                //
                //   case 'screen':
                //   // افتح شاشة داخل التطبيق
                //     if (data == 'activity') {
                //       Navigator.pushNamed(context, StudentActivityScreen.routeName);
                //     }
                //     break;
                //}
                if (item.link != null && item.link!.isNotEmpty) {
                  launchUrl(Uri.parse(item.link!));  // افتح اللينك أولاً لو موجود
                }
                else if (item.pdf != null && item.pdf!.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                      backgroundColor: MyColors.whiteColor,
                      title: Text("تحميل ${item.name}"),
                      titleTextStyle: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic",
                      ),
                      content: Text("هل تريد فتح ${item.name}؟"),
                      contentTextStyle: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("إلغاء",
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Noto Kufi Arabic",
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            launchUrl(Uri.parse(item.pdf!));
                          },
                          child: Text("فتح",
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Noto Kufi Arabic",
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  if(item.name == 'انشطه طلابيه'){
                    Navigator.pushNamed(context, StudentActivityScreen.routeName);
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('لا يوجد محتوى لعرضه')),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}



