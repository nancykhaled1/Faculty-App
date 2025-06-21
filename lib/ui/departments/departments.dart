import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/departments/cubit/states.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cubit/departmentviewmodel.dart';
import 'dept_details.dart';

class Department extends StatelessWidget{
  static const String routeName = 'dept';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DepartmentScreenviewmodel(
            getAllDepartmentUseCase: injectGetAllDepartmentUseCase())..getDepartment(),
      child: BlocBuilder<DepartmentScreenviewmodel,DepartmentStates>(
          builder: (context, state) {
            if (state is DepartmentLoadingStates) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is DepartmentErrorStates) {
              return Center(child: Text(state.errorMessage?? ''));
            }
            else if (state is DepartmentSuccessStates) {
              final List<DepartmentResponseEntity> data = state.departmentResponseEntity;
              return SafeArea(
                child: Scaffold(
                  backgroundColor: MyColors.backgroundColor,
                  body: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 200.h,
                                right: 20.w,
                                child: Image.asset(
                                    'assets/images/line2.png')),
                            Positioned(
                                top: 410.h,
                                right: 190.w,
                                child: Image.asset(
                                    'assets/images/line.png')),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('الاقسام المتاحة',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Noto Kufi Arabic"
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                ...data.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  final department = entry.value;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 10.h
                                    ),
                                    child: Align(
                                      alignment: index.isEven ? Alignment.centerRight : Alignment.centerLeft,
                                      child: _buildDepartmentCard(
                                        department: department,
                                        context: context,
                                      ),
                                    ),
                                  );
                                }).toList(),

                              ],
                            ),
                          ],
                        )

                    ),
                  ),
                ),
              );
            }
            return Container(); // initial state
          }

      ),
    );
        }


  }


  Widget _buildDepartmentCard({
    required BuildContext context,
    required DepartmentResponseEntity department,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DepartmentDetails(department: department,),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 198.sp,
            height: 210.sp,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.r),
                topLeft: Radius.circular(5.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: MyColors.blackColor.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.r),
                    topLeft: Radius.circular(5.r),
                  ),
                  child: Image.network(
                    department.image ?? 'not found',
                    fit: BoxFit.cover,
                    width: 198.sp,
                    height: 100.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    department.name ?? 'not found',
                    style: TextStyle(
                      color: MyColors.softBlackColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(
                    department.about ?? 'not found'.replaceAll('\n', ' '),
                    style: TextStyle(
                      height: 1.5,
                      color: MyColors.softBlackColor,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 155.w,
            child: SvgPicture.asset('assets/images/circle.svg'),
          ),
        ],
      ),
    );
  }




