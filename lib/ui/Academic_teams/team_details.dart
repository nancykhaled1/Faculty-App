import 'package:faculty/ui/Academic_teams/Academic_teams.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_cubit.dart';
import 'package:faculty/ui/Academic_teams/cubit/academic_teams_state.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 35 ,right: 12),
        child: Column(
          children: [
            // زر العودة
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => AcademicTeams()),
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

            // المحتوى القابل للتمرير
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            year.year ?? '',
                            style: TextStyle(
                              color: MyColors.softBlackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Noto Kufi Arabic",
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(height: 50.h),
                        _buildDetailRow('جدول الفرقة الدراسية للفصل الدراسي الأول - العام الأكاديمي 2024/2025 ', year.lectureSchedule),
                          SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                        _buildDetailRow('جدول امتحانات العملي للفصل الدراسي الأول للعام الأكاديمي 2024/2025', year.practicalExam),
                          SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                        _buildDetailRow('جدول امتحانات النهائية للفصل الدراسي الأول للعام الأكاديمي 2024/2025', year.exam),
                          SizedBox(height: 15.h),
                Divider(color: Color(0XFFD4D4D4), thickness: 1, height: 20),
                SizedBox(height: 15.h),

                        _buildDetailRow(
                     "أرقام الجلوس الخاصة بالمستوى",
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
        onTap: (url != null && url.isNotEmpty)
            ? () async {
                try {
                  final uri = Uri.parse(url);
                  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                } catch (e) {
                  _showErrorDialog(url, e.toString());
                }
              }
            : null,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: "Noto Kufi Arabic",
            fontWeight: FontWeight.w500,

           
            color: (url != null && url.isNotEmpty)
                ? MyColors.primaryColor
                : null,
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String? url, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid URL'),
        content: SingleChildScrollView(
          child: Text('Could not launch the URL: $url\n\nError: $error'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: url ?? ''));
              Navigator.of(context).pop();
            },
            child: const Text('Copy URL'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
