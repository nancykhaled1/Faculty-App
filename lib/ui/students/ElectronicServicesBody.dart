import 'package:faculty/domain/entities/studentEntity.dart';
import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cubit/states.dart';
import 'cubit/studentviewmodel.dart';


class ElectronicServicesBody extends StatefulWidget {
  final List<StudentResponseEntity> services;

  ElectronicServicesBody({required this.services});

  @override
  State<ElectronicServicesBody> createState() => _ElectronicServicesBodyState();
}

class _ElectronicServicesBodyState extends State<ElectronicServicesBody> {
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
    print("عدد الخدمات: ${widget.services.length}");
    return BlocListener<StudentViewModel,StudentStates>(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 15.h),
          itemCount: widget.services.length,
          itemBuilder: (context, index) {
            final item = widget.services[index];
            return ListTile(
              leading:Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h , vertical: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(color: MyColors.primaryColor),
                  color: MyColors.whiteColor
                ),
                child: Image.network(
                  item.image ?? '',
                  width: 25,
                  height: 25,
                  // size: 30,
                  // color: Colors.blue,
                ),
              ),
              title: Text(item.name ?? 'not found', style: TextStyle(
                  color: MyColors.softBlackColor,
                  fontFamily: "Noto Kufi Arabic",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500)),
              subtitle: Text(item.description ?? '',
                  style: TextStyle(
                      color: MyColors.greyColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500)),

              onTap: () {
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('لا يوجد محتوى لعرضه')),
                  );
                }              },
            );
          },
        ),
      ),
      listener: (context,state) {
        // if (state is StudentLoadingStates) {
        //    Center(child: CircularProgressIndicator());
        // }
        // else if (state is StudentErrorStates) {
        //    Center(child: Text(state.errorMessage?? ''));
        // }
        // else if (state is StudentSuccessStates) {
        // }
      },
    );

  }
}



