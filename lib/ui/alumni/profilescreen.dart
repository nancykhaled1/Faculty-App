import 'dart:io';

import 'package:faculty/ui/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../data/local/preferences.dart';
import '../../domain/usecase/di.dart';
import '../../utils/colors.dart';
import '../auth/authProvider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'pdfviewer.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController emailCompanyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String employmentStatus = "unemployee";

  File? cvController;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await SharedPrefsHelper.getUserData();
      print("📥 loaded user data: $data");
      nameController.text = data['username'] ?? '';
      emailController.text = data['email'] ?? '';

      String rawStatus = data['employment_status'] ?? 'unemployee';
      if (!employmentOptionsMap.containsKey(rawStatus)) {
        employmentStatus =
            employmentOptionsMap.entries
                .firstWhere(
                  (entry) => entry.value == rawStatus,
                  orElse: () => MapEntry('unemployee', 'غير موظف'),
                )
                .key;
      } else {
        employmentStatus = rawStatus;
      }

      // ✅ صححنا هنا
      if (employmentStatus == 'employee') {
        jobController.text = data['jobName'] ?? '';
        emailCompanyController.text = data['companyEmail'] ?? '';
        phoneController.text = data['companyPhone'] ?? '';
        urlController.text = data['companyLink'] ?? '';
        descriptionController.text = data['aboutCompany'] ?? '';
        locationController.text = data['location'] ?? '';
        if (data['cv'] != null && data['cv'].toString().isNotEmpty) {
          cvController = File(data['cv']??'');
        }

      }

      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).setEmploymentStatus(employmentStatus);

      setState(() {});
    });
  }

  void saveChanges() async {
    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final jobName = jobController.text.trim();
    final companyEmail = emailCompanyController.text.trim();
    final companyPhone = phoneController.text.trim();
    final companyUrl = urlController.text.trim();
    final companyDesc = descriptionController.text.trim();
    final location = locationController.text.trim();
    final employmentStatus = Provider.of<AuthProvider>(context, listen: false).employmentStatus;

    await SharedPrefsHelper.saveUserData(
      username: username,
      email: email,
      employmentStatus: employmentStatus,
      jobName: jobName,
      companyEmail: companyEmail,
      companyPhone: companyPhone,
      companyLink: companyUrl,
      aboutCompany: companyDesc,
      location: location,
      cv: cvController?.path,


    );

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUserDataFromPrefs(); // تحديث الـ provider بعد التخزين


    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("تم حفظ التعديلات")));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10.sp, right: 20.sp,left: 10.sp),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
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
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

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
                  top: 5,
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
                          child: Container(
                            width: 75.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor.withOpacity(0.2), // لون الخلفية
                              borderRadius: BorderRadius.circular(10.r), // نفس الشكل القديم
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              nameController.text.isNotEmpty
                                  ? nameController.text[0]
                                  : '?',
                              style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor,
                                fontFamily: "Noto Kufi Arabic",
                              ),
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
                              SizedBox(height: 10.h),
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
                              // Consumer<AuthProvider>(
                              //   builder: (_, provider, __) => Text(
                              //     provider.employmentStatus,
                              //     style: TextStyle(
                              //       fontSize: 13.sp,
                              //       fontFamily: "Noto Kufi Arabic",
                              //       color: MyColors.primaryColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildTextField("اسم المستخدم", nameController),
            buildTextField("البريد الإلكتروني", emailController),
            buildDropdownField("حالة التوظيف"),
            if (authProvider.employmentStatus == 'employee') ...[
              buildTextField("اسم الوظيفة", jobController),
              buildTextField(
                "البريد الإلكتروني للشركة",
                emailCompanyController,
              ),
              buildTextField("رقم الهاتف", phoneController),
              buildTextField("رابط الشركة", urlController),
              buildTextField("وصف الشركة", descriptionController),
              buildCVField("السيرة الذاتية"),
            ],
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  foregroundColor: MyColors.whiteColor,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 90.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text("حفظ التغيير", style: TextStyle(fontSize: 15.sp, fontFamily: "Noto Kufi Arabic")),
              ),
            ),
          ],
        ),
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
    return Consumer<AuthProvider>(
      builder:
          (_, provider, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label , style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400,
                  fontFamily: "Numans", color: MyColors.greyColor)),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: MyColors.whiteColor, // ✅ لون الخلفية للقائمة المنسدلة
                    style: TextStyle(
                      fontFamily: 'Numans',
                      fontSize: 14.sp,
                      color: MyColors.greyColor, // ✅ لون الخط
                    ),
                    value: provider.employmentStatus,
                    items:
                        employmentOptionsMap.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key, // "employee"
                            child: Text(entry.value), // "موظف"
                          );
                        }).toList(),
                    onChanged: (val) {
                      provider.setEmploymentStatus(val!);
                    },
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
    );
  }
  

  Widget buildCVField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null && result.files.single.path != null) {
              setState(() {
                cvController = File(result.files.single.path!);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.picture_as_pdf, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    cvController?.path.split('/').last ?? 'اضغط لاختيار ملف PDF',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (cvController != null)
                  IconButton(
                    icon: Icon(Icons.open_in_new, color: MyColors.primaryColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PDFViewerScreen(filePath: cvController!.path),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }



  Map<String, String> employmentOptionsMap = {
    "employee": "موظف",
    "unemployee": "غير موظف",
    "seeking_job": "باحث عن عمل",
    "postgraduate": "طالب دراسات عليا",
    "freelance": "يعمل عمل حر",
  };
}


