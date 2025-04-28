import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../data/local/alumni_model.dart';
import '../../utils/colors.dart';
import '../auth/authProvider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  // final Alumni alumni;
  //
  // const ProfileScreen({required this.alumni});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController cvController;
  late TextEditingController jobController;



  String employmentStatus = "يعمل عامل حر";
  List<String> employmentOptions = ["يعمل عامل حر", "باحث عن عمل", "موظف","طالب دراسات عليا", "غير موظف"];
  bool _isInit = false; // عشان نتأكد إن الكود ينفذ مرة واحدة فقط
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      final alumni = Provider.of<AuthProvider>(context).alumni;

      if (alumni != null) {
        nameController = TextEditingController(text: alumni.name);
        emailController = TextEditingController(text: alumni.email);
        cvController = TextEditingController(text: alumni.resumeFileName ?? "");
        employmentStatus = employmentOptions.contains(alumni.employmentStatus)
            ? alumni.employmentStatus
            : employmentOptions[0];
        jobController = TextEditingController(text: alumni.jobInfo?.jobTitle ?? "");
      }

      _isInit = true;
      _isLoading = false;
    }
  }


  @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      cvController.dispose();
      jobController.dispose();
      super.dispose();
    }

  void saveChanges() {
    final alumni = Provider.of<AuthProvider>(context).alumni!;
    final updatedAlumni = Alumni(
      name: nameController.text,
      email: emailController.text,
      password: alumni.password, // نفس القديم
      resumeFileName: cvController.text,
      employmentStatus: employmentStatus,
    );

    // هنا ممكن تبعته ل Firebase أو تطبعه
    print("تم تحديث البيانات بنجاح: ${updatedAlumni.name}");
  }

  @override
  Widget build(BuildContext context) {
    final alumni = Provider.of<AuthProvider>(context).alumni!;

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // كونتينر يحتوي على صورة البروفايل والاسم والبريد الإلكتروني
              Stack(
                alignment: Alignment.center,
                children: [
                  // الخلفية الملونة (الشريط)
                  Container(
                    height: 120.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.primaryColor, MyColors.secondryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  // الكونتينر الخاص بالمعلومات
                  Positioned(
                    top: 4, // رفع الكونتينر الأبيض لأعلى قليلًا
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      //height: 100.h,
                      decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        //  mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                'assets/images/Rectangle 40.png', // مسار الصورة
                                width: 70.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:25.h, horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alumni.name}",
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Noto Kufi Arabic"
                                  ),
                                ), 
                                SizedBox(height: 5.h),     
                                SizedBox(
                                  width: 180.w, // حطي العرض اللي يناسبك حسب تصميمك
                                  child: Text(
                                    "${alumni.email}",
                                    style: TextStyle(
                                      color: MyColors.greyColor,
                                      fontSize: 15.sp,
                                      fontFamily: "Noto Kufi Arabic",
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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



              SizedBox(height: 20),

              // الحقول القابلة للتحرير
              buildTextField("اسم المستخدم", nameController),
              buildTextField("البريد الإلكتروني", emailController),
              buildTextField(
                "السيرة الذاتية",
                cvController,
                isReadOnly: true,
                isFileField: true,
              ),

              // حالة التوظيف Dropdown
              buildDropdownField("حالة التوظيف"),


              SizedBox(height: 20),

              // زر الحفظ
              Padding(
                padding:  EdgeInsets.all(8.sp),
                child: ElevatedButton(
                  onPressed: saveChanges,
                  child: Text(
                    "حفظ التغيير",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Noto Kufi Arabic",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: MyColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 90.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label,
      TextEditingController controller, {
        bool isReadOnly = false,
        bool isFileField = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, fontFamily: "Numans", color: MyColors.greyColor),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            prefixIcon: isFileField
                ? Icon(Icons.picture_as_pdf, color: Colors.red)
                : null,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, fontFamily: "Numans", color: MyColors.greyColor),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(10.r),
            // border: Border.all(color: MyColors.greyColor, width: 0.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: MyColors.whiteColor,
              value: employmentStatus,
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
                setState(() {
                  employmentStatus = newValue!;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }



}
