import 'package:faculty/domain/usecase/di.dart';
import 'package:faculty/ui/alumni/cubit/states.dart';
import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/local/preferences.dart';
import '../../utils/colors.dart';
import '../auth/authProvider.dart';
import 'cubit/profileviewmodel.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> employmentOptions = ["يعمل عامل حر", "باحث عن عمل", "موظف", "طالب دراسات عليا", "غير موظف"];
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await SharedPrefsHelper.getUserData();
      if (data['username'] != null) nameController.text = data['username']!;
      if (data['email'] != null) emailController.text = data['email']!;
      if (data['employment_status'] != null) {
        Provider.of<AuthProvider>(context, listen: false).setEmploymentStatus(data['employment_status']!);
      }
    });
  }

  void saveChanges() async {
    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final employmentStatus = Provider.of<AuthProvider>(context, listen: false).employmentStatus;

    await SharedPrefsHelper.saveUserData(
      username: username,
      email: email,
      employmentStatus: employmentStatus,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم حفظ التعديلات")),
    );
  }

  String validatedStatus(String? status) {
    if (status == null || !employmentOptions.contains(status)) {
      return employmentOptions.first; // أو أي قيمة افتراضية
    }
    return status;
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final alumni = authProvider.alumni;
    final token = authProvider.token ?? '';
    final id = alumni?.graduationData?.id;

    if (id == null || token.isEmpty) {
      return Scaffold(body: Center(child: Text("لا توجد بيانات مستخدم")));
    }

    return BlocProvider(
      create: (_) => ProfileViewModel(getUserdataUseCase: injectGetUserDataServiceUseCase())
        ..getUserData(id, token),
      child: BlocBuilder<ProfileViewModel, UserDataStates>(
        builder: (context, state) {
          if (state is UserDataLoadingStates) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is UserDataErrorStates) {
            return Center(child: Text(state.errorMessage ?? 'حدث خطأ'));
          }
          else if (state is UserDataSuccessStates) {
            if (!_isInit) {
              final data = state.userDataResponseEntity;
              final username = data.graduationData?.user?.username ?? '';
              final email = data.graduationData?.user?.email ?? '';
              final employment = data.graduationData?.employmentStatus;

              nameController.text = username;
              emailController.text = email;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<AuthProvider>(context, listen: false)
                    .setEmploymentStatus(validatedStatus(employment));
                SharedPrefsHelper.saveUserData(
                  username: username,
                  email: email,
                  employmentStatus: validatedStatus(employment),
                );
              });

              _isInit = true;
            }


            return Scaffold(
              backgroundColor: MyColors.backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 120.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [MyColors.primaryColor, MyColors.secondryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.asset(
                                      'assets/images/Rectangle 40.png',
                                      width: 70.w,
                                      height: 70.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nameController.text,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Noto Kufi Arabic",
                                          color: MyColors.blackColor,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          emailController.text,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Noto Kufi Arabic",
                                            color: MyColors.greyColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Consumer<AuthProvider>(
                                        builder: (_, provider, __) => Text(
                                          provider.employmentStatus,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontFamily: "Noto Kufi Arabic",
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    buildTextField("اسم المستخدم", nameController),
                    buildTextField("البريد الإلكتروني", emailController),
                    buildDropdownField("حالة التوظيف"),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: saveChanges,
                      child: Text("حفظ التغيير", style: TextStyle(fontSize: 15.sp, fontFamily: "Noto Kufi Arabic")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: MyColors.whiteColor,
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 90.w),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(); // Initial
        },
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, fontFamily: "Numans", color: MyColors.greyColor)),
        SizedBox(height: 5.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, fontFamily: "Numans", color: MyColors.greyColor)),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Consumer<AuthProvider>(
            builder: (_, provider, __) => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: provider.employmentStatus,
                icon: Icon(Icons.arrow_drop_down, color: MyColors.greyColor),
                isExpanded: true,
                style: TextStyle(fontSize: 15.sp, fontFamily: "Numans", color: MyColors.blackColor),
                items: employmentOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  provider.setEmploymentStatus(newValue!);
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
