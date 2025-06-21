import 'dart:io';
import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class TeamDetails extends StatefulWidget {
  final int teamId;

  const TeamDetails({Key? key, required this.teamId}) : super(key: key);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  final List<Map<String, String>> pdfs = [
    {
      'title': 'جدول الفرقة الدراسية للفصل الدراسي الأول - العام الأكاديمي 2024/2025',
      'path': 'assets/pdf/الجدول الدراسية (محاضرات + سكاشن).pdf',
    },
    {
      'title': 'جدول امتحانات العملي للفصل الدراسي الأول للعام الأكاديمي 2024/2025',
      'path': 'assets/pdf/جدول الترم التاني .pdf',
    },
    {
      'title': 'جدول امتحانات النهائية للفصل الدراسي الأول للعام الأكاديمي 2024/2025',
      'path': 'assets/pdf/جدول الترم التاني .pdf',
    },
    {
      'title': 'أرقام الجلوس الخاصة بالمستوى',
      'path': 'assets/pdf/ارقام الجلوس.pdf',
    },
  ];

  String getTeamTitle() {
    switch (widget.teamId) {
      case 1:
        return 'الفرقة الأولى';
      case 2:
        return 'الفرقة الثانية';
      case 3:
        return 'الفرقة الثالثة';
      case 4:
        return 'الفرقة الرابعة';
      default:
        return 'الفرقة الدراسية';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 35, right: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AcademicTeams()),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/Upload.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    getTeamTitle(),
                    style: TextStyle(
                      color: MyColors.softBlackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Noto Kufi Arabic",
                    ),
                    textAlign: TextAlign.right,
                  //textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.separated(
                itemCount: pdfs.length,
                separatorBuilder: (context, index) => const Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 30),
                itemBuilder: (context, index) {
                  return _buildDetailRow(pdfs[index]['title']!, pdfs[index]['path']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String assetPath) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () async {
          try {
            final dir = await getApplicationDocumentsDirectory();
            final file = File('${dir.path}/${assetPath.split('/').last}');

            if (!await file.exists()) {
              final byteData = await rootBundle.load(assetPath);
              await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
            }
            await OpenFilex.open(file.path);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open file: $e')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w500,
              color: MyColors.primaryColor,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
