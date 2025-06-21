import 'package:faculty/utils/colorManager.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/send_complaint_cubit.dart';
import '../../data/models/response/complaint_model.dart';

import '../../utils/dialog.dart';
import 'complaint.dart';
import 'inquiriesComplaint.dart';

class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key});

  @override
  _SendComplainState createState() => _SendComplainState();
}

class _SendComplainState extends State<SendComplaint> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    controller.dispose(); // تنظيف الكونترولر عند التخلص من الصفحة
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendComplaintCubit, SendComplaintState>(
      listener: (context, state) {
        if (state is SendComplaintSuccess) {
          print('Complaint sent successfully!');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BuildDialog(
                message: "تم ارسال رسالتك بنجاح",
                subMessage: "رسالتك قيد الانتظار",
                onDismiss: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Inquriescomplaint()),
                  );
                },
              );
            },
          );
        } else if (state is SendComplaintError) {
          print('Error sending complaint: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ في إرسال الشكوى: ${state.message}')),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          resizeToAvoidBottomInset: true, // ✅ مهم علشان الكيبورد
          body: SingleChildScrollView(
            // ✅ يخلي المحتوى يقدر يتحرك لما الكيبورد يظهر
            child: Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                right: 10.w,
                bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ مساحة حسب الكيبورد
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 الصف في الأعلى
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Complaint()),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/backarrow.svg",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // 🔹 حقل اسم الشكوى
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
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
                    ),

                    SizedBox(height: 20.h),

                    // 🔹 صندوق كتابة الشكوى
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
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
                    ),

                    SizedBox(height: 100.h), // مسافة قبل زر الإرسال

                    // 🔹 زر الإرسال
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: SizedBox(
                          height: 45.h,
                          width: 343.w,
                          child: BlocBuilder<SendComplaintCubit, SendComplaintState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state is SendComplaintLoading 
                                  ? null 
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        print('Sending complaint: ${controller1.text} - ${controller.text}');
                                        final complaint = ComplaintModel(
                                          title: controller1.text,
                                          content: controller.text,
                                        );
                                        context.read<SendComplaintCubit>().sendComplaint(complaint);
                                      }
                                    },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.primaryColor0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: state is SendComplaintLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      "إرسال ",
                                      style: TextStyle(
                                        color: ColorManager.homePageColor,
                                        fontSize: 15.sp,
                                        fontFamily: "Noto Kufi Arabic",
                                      ),
                                    ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}