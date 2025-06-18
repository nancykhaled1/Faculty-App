import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/students/cubit/states.dart';
import 'package:faculty/ui/students/cubit/studentviewmodel.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/studentEntity.dart';

class StudentScreen extends StatefulWidget{
  static const String routeName = 'student';

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentViewModel(
        getStudentServiceUseCase: injectGetStudentServiceUseCase())..getStudentService(),
      child: BlocBuilder<StudentViewModel,StudentStates>(
        builder: (context,state){
          if (state is StudentLoadingStates) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is StudentErrorStates) {
            return Center(child: Text(state.errorMessage?? ''));
          }
          else if (state is StudentSuccessStates) {
            final viewModel = BlocProvider.of<StudentViewModel>(context);
            return SafeArea(
                child: Scaffold(
                  backgroundColor: MyColors.backgroundColor,
                  body: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Builder(
                            builder: (context){
                              final viewModel = BlocProvider.of<StudentViewModel>(context);
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.categories.length,
                                itemBuilder: (context, index) {
                                  bool isSelected = index == viewModel.selectedIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      if (viewModel.selectedIndex != index) {
                                        setState(() {
                                          viewModel.selectedIndex = index;
                                          viewModel.selectedType = viewModel.categories[index].toLowerCase();

                                        });
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: isSelected ? MyColors.backgroundColor : Colors.white,
                                          borderRadius: BorderRadius.circular(7.r),
                                          border: Border.all(
                                            color: isSelected ? MyColors.yellowColor : Colors.transparent,
                                            //  width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              viewModel.categoryIcons[index],
                                              color: isSelected ? MyColors.yellowColor : MyColors.blackColor,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              viewModel.categories[index],
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: "Noto Kufi Arabic",
                                                fontWeight: FontWeight.w400,
                                                color: isSelected ? MyColors.yellowColor : MyColors.blackColor,
                                              ),
                                            ),
                                          ],
                                        )

                                    ),
                                  );
                                },
                              );
                            },

                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(child: viewModel.screens[viewModel.selectedIndex]),
                      ],
                    ),
                  ),
                ));
          }
          return Container();
        },

      
      
      ),
    );

  }
}