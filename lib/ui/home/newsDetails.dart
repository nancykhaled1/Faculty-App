import 'package:faculty/data/models/response/newsModel.dart';
import 'package:faculty/ui/home.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Newsdetails extends StatefulWidget {
  final NewsModel news;

  const Newsdetails({super.key, required this.news});

  @override
  State<Newsdetails> createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/backarrow.svg",
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.news.image ?? "",
                    width: 342.w,
                    height: 255.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/doctors.png"),
                  ),
                ),
                SizedBox(height: 30.h),  
                Text(
                  widget.news.title ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Noto Kufi Arabic",
                    color: MyColors.primaryColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.news.content ?? "",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Noto Kufi Arabic",
                    color: MyColors.softBlackColor,
                    height: 2 .h,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                ),
                
              
                if (widget.news.images != null && widget.news.images!.isNotEmpty) ...[
                  SizedBox(height: 30.h),
                  
                  SizedBox(height: 15.h),
                  Container(
                    height: 152.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.news.images!.length,
                      itemBuilder: (context, index) {
                        final newsImage = widget.news.images![index];
                        return Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
                          width: 147.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              newsImage.image ?? "",
                              width: 147.w,
                              height: 152.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 147.w,
                                    height: 152.h,
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
