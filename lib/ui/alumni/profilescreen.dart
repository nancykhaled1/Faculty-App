import 'package:faculty/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController nameController = TextEditingController(
    text: "أحمد خالد",
  );
  TextEditingController emailController = TextEditingController(
    text: "Ahm12@gmail.com",
  );
  TextEditingController cvController = TextEditingController(text: "اسم الملف");
  TextEditingController jobController = TextEditingController(text: "مهندس برمجيات");

 // TextEditingController locationController = TextEditingController();

  TextEditingController emailCompanyController = TextEditingController(text: "asdfgh@gmail.com");

  TextEditingController phoneController = TextEditingController(text: "01234668");

  TextEditingController urlController = TextEditingController(text: "asdfhhut");

  TextEditingController descriptionController = TextEditingController(text: "شركه تعمل باعمال السوفت وير");

  String employmentStatus = "يعمل عامل حر";
  List<String> employmentOptions = ["يعمل عامل حر", "باحث عن عمل", "موظف","طالب دراسات عليا", "غير موظف"];

  void saveChanges() {
    // هنا يتم حفظ البيانات عند الضغط على الزرار
    print("تم حفظ البيانات بنجاح");
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 100.h,
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
                                  "أحمد خالد",
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Noto Kufi Arabic"
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Ahm12@gmail.com",
                                  style: TextStyle(
                                      color: MyColors.greyColor,
                                      fontSize: 15.sp,
                                      fontFamily: "Noto Kufi Arabic",
                                      fontWeight: FontWeight.w500
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
              buildTextField("اسم الوظيفة", jobController),
              buildTextField("البريد الإلكتروني", emailCompanyController),
              buildTextField("رقم الهاتف", phoneController),
              buildTextField("رابط الشركة", urlController),
              buildTextField("وصف الشركة", descriptionController),

              SizedBox(height: 20),

              // زر الحفظ
              ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text("حفظ التغيير", style: TextStyle(color: Colors.white)),
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
