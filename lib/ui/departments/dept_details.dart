import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/departments/cubit/departmentviewmodel.dart';
import 'package:faculty/ui/departments/cubit/states.dart';
import 'package:faculty/ui/departments/departments.dart';
import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/departmentEntity.dart';

class DepartmentDetails extends StatefulWidget {
  final DepartmentResponseEntity department;

  DepartmentDetails({super.key, required this.department});

  @override
  State<DepartmentDetails> createState() => _DepartmentDetailsState();
}

class _DepartmentDetailsState extends State<DepartmentDetails> {
  late DepartmentScreenviewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DepartmentScreenviewmodel(
      getAllDepartmentUseCase: injectGetAllDepartmentUseCase(),
    );
    viewModel.selectDepartment(widget.department); // 🟢 هنا التصنيف
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DepartmentScreenviewmodel, DepartmentStates>(
      bloc: viewModel,
      listener: (context, state)
    {
      if (state is DepartmentLoadingStates) {
        Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: const Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
          ),
        );
      }
      if (state is DepartmentErrorStates) {
        Center(child: Text('حدث خطأ: ${state.errorMessage}'));
      }
    },
    child:  SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0, // منع تغير اللون عند التمرير
          leading: GestureDetector(
            onTap: () {
              if (ModalRoute
                  .of(context)
                  ?.settings
                  .name ==
                  Department.routeName) {
                Navigator.pushNamed(context, HomePage.routeName);
              } else {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: 10.sp, right: 20.sp, left: 10.sp),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/icons/backarrow.svg', // الأيقونة الافتراضية
                  width: 5.w,
                  height: 5.h,
                  // color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30.sp,
                      right: 30.sp,
                      left: 30.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نبذة عن ${widget.department.name}',
                          style: TextStyle(
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                                color: MyColors.yellowColor),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.r),
                                  topLeft: Radius.circular(16.r),
                                ),
                                child: Image.network(
                                  widget.department.image ?? 'not found',
                                  width: double.infinity,
                                  height: 200.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Text(
                                  widget.department.about ?? 'not found',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: MyColors.softBlackColor,
                                    height: 2.h,
                                    fontSize: 10.sp,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: 342.w, // تحديد العرض المطلوب
                          child: Divider(
                            color: Color(0XFFD4D4D4), // لون الخط
                            thickness: 1, // سمك الخط
                            height: 20, // المسافة حول الخط
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            'الرؤية و الرسالة',
                            style: TextStyle(
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        _buildInfoContainer(
                          'رؤية و تخطيط',
                          widget.department.vision ?? '',
                        ),
                        SizedBox(height: 30.h),
                        _buildInfoContainer(
                          'رسالة القسم',
                          widget.department.mission ?? '',
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          'أعضاء هيئة التدريس',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 15.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'مدرس :',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildProfessorsList(viewModel.teachers),
                        Text(
                          'مدرس مساعد :',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 14.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildProfessorsList(viewModel.assistants),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: 342.w, // تحديد العرض المطلوب
                          child: Divider(
                            color: Color(0XFFD4D4D4), // لون الخط
                            thickness: 1, // سمك الخط
                            height: 20, // المسافة حول الخط
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'لائحة القسم',
                          style: TextStyle(
                            color: MyColors.softBlackColor,
                            fontSize: 15.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            if (widget.department.pdf != null) {
                              // open PDF link
                              showDialog(
                                context: context,
                                builder:
                                    (_) =>
                                    AlertDialog(
                                      backgroundColor: MyColors
                                          .whiteColor,
                                      title: Text("تحميل لائحة القسم"),
                                      titleTextStyle: TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Noto Kufi Arabic",
                                      ),
                                      content: Text(
                                          "هل تريد فتح لائحة القسم؟"),
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
                                              color: MyColors
                                                  .primaryColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Noto Kufi Arabic",
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            launchUrl(Uri.parse(
                                                widget.department.pdf!));
                                          },
                                          child: Text("فتح",
                                            style: TextStyle(
                                              color: MyColors
                                                  .primaryColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Noto Kufi Arabic",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          },
                          child: Center(
                            child: SingleChildScrollView(
                              child: Container(
                                width: 217.w,
                                height: 100.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: MyColors.softYellowColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: MyColors.yellowColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/Download.svg',
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "اضغط هنا لتحميل الملف",
                                        style: TextStyle(
                                          color: MyColors.blackColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Noto Kufi Arabic",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 70.h,
                right: 310.w,
                child: Image.asset('assets/images/white_circle.png'),
              ),
              Positioned(
                top: 57.h,
                right: 300.w,
                child: Image.asset('assets/images/Chain.png'),
              ),
            ],
          ),
        ),
      ),
      //child:
    )
    );

  }

  Widget _buildInfoContainer(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: MyColors.yellowColor,
                fontFamily: "Noto Kufi Arabic",
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 2.sp,
                color: MyColors.softBlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 8.sp,
                fontFamily: "Noto Kufi Arabic",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessorsList(List<DoctorsDetailEntity> doctors) {
    return SizedBox(
      width: 310.w,
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(doctor.image ?? 'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small_2x/default-avatar-icon-of-social-media-user-vector.jpg'),
                ),
                SizedBox(height: 10.h),
                Text(
                  doctor.name ?? '',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: "Noto Kufi Arabic",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // الـ Container الأساسي بالخلفية الصفراء
                    GestureDetector(
                      onTap: () {
                        if (doctor.cv != null) {
                          // open PDF link
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  backgroundColor: MyColors.whiteColor,
                                  title: Text("تحميل السيرة الذاتية"),
                                  titleTextStyle: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Noto Kufi Arabic",
                                  ),
                                  content: Text("هل تريد فتح السيرة الذاتية؟"),
                                  contentTextStyle: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 12.sp,
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
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Noto Kufi Arabic",
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        launchUrl(Uri.parse(doctor.cv!));
                                      },
                                      child: Text("فتح",
                                        style: TextStyle(
                                          color: MyColors.primaryColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Noto Kufi Arabic",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                      child: Container(
                        width: 90.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: MyColors.softYellowColor,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: MyColors.yellowColor),
                        ),
                        child: Text(
                          "سيرة ذاتية",
                          style: TextStyle(
                            color: MyColors.yellowColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
