import 'package:faculty/colorManager.dart';
import 'package:faculty/complaint/complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key});

  @override
  _SendComplainState createState() => _SendComplainState();
}

class _SendComplainState extends State<SendComplaint> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();

  @override
  void dispose() {
    controller.dispose(); // تنظيف الكونترولر عند التخلص من الصفحة
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ مهم علشان الكيبورد
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ يخلي المحتوى يقدر يتحرك لما الكيبورد يظهر
          child: Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ مساحة حسب الكيبورد
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 الصف في الأعلى
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Complaint()),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/Upload.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // 🔹 حقل اسم الشكوى
                TextField(
                  controller: controller1,
                  maxLines: 2, // يسمح بكتابة نص طويل
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "اسم الشكوى",
                    hintStyle: TextStyle(
                        fontSize: 12.sp,
                        color: ColorManager.hintText,
                        fontFamily: "Noto Kufi Arabic"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Color(0xffFAA926)),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // 🔹 صندوق كتابة الشكوى
                TextField(
                  controller: controller,
                  maxLines: 10, // يسمح بكتابة نص طويل
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "نص الشكوى",
                    hintStyle: TextStyle(
                        fontSize: 12.sp,
                        color: ColorManager.hintText,
                        fontFamily: "Noto Kufi Arabic"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),

                SizedBox(height: 100.h), // مسافة قبل زر الإرسال

                // 🔹 زر الإرسال
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      height: 45.h,
                      width: 343.w,
                      child: ElevatedButton(
                        onPressed: () {
                          // 🟢 هنا أكشن الإرسال
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "إرسال ",
                          style: TextStyle(
                            color: ColorManager.homePageColor,
                            fontSize: 15.sp,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
