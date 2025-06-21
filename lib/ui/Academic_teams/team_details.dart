import 'dart:io';
import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_cubit.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_state.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class TeamDetails extends StatefulWidget {
  final int teamId;

  const TeamDetails({Key? key, required this.teamId}) : super(key: key);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AcademicTeamsCubit>().getAcademicYear(widget.teamId);
  }

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

  Future<void> openPdfFromUrl(String? url, String title) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يوجد ملف PDF متاح')),
      );
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final fileName = '${title.replaceAll(RegExp(r'[^\w\s-]'), '')}.pdf';
        final file = File('${dir.path}/$fileName');

        await file.writeAsBytes(response.bodyBytes);
        await OpenFilex.open(file.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في تحميل الملف')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في فتح الملف: $e')),
      );
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: BlocBuilder<AcademicTeamsCubit, AcademicTeamsState>(
                builder: (context, state) {
                  if (state is AcademicTeamsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AcademicTeamsError) {
                    return Center(child: Text(state.message));
                  } else if (state is AcademicTeamsSuccess) {
                    final year = state.academicYear;
                    return ListView(
                      children: [
                        _buildDetailRow(
                          'جدول الفرقة الدراسية للفصل الدراسي الأول - العام الأكاديمي 2024/2025',
                          year.lectureSchedule,
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                        SizedBox(height: 15.h),
                        _buildDetailRow(
                          'جدول امتحانات العملي للفصل الدراسي الأول للعام الأكاديمي 2024/2025',
                          year.practicalExam,
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                        SizedBox(height: 15.h),
                        _buildDetailRow(
                          'جدول امتحانات النهائية للفصل الدراسي الأول للعام الأكاديمي 2024/2025',
                          year.exam,
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                        SizedBox(height: 15.h),
                        _buildDetailRow(
                          'أرقام الجلوس الخاصة بالمستوى',
                          year.seatingNumber,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String? url) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () => openPdfFromUrl(url, title),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "Noto Kufi Arabic",
              fontWeight: FontWeight.w500,
              color: (url != null && url.isNotEmpty)
                  ? MyColors.primaryColor
                  : Colors.grey,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
