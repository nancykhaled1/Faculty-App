import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatelessWidget {
  final String filePath;

  const PDFViewerScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
          backgroundColor: MyColors.backgroundColor,
          scrolledUnderElevation: 0, // منع تغير اللون عند التمرير
          elevation: 0,
          title: Text("عرض السيرة الذاتية")),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}