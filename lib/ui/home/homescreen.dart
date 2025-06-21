import 'package:faculty/ui/home/cubit/states/news_cubit.dart';
import 'package:faculty/ui/home/cubit/states/vision_mission_state.dart';
import 'package:faculty/ui/home/cubit/states/vision_mission_cubit.dart';
import 'package:faculty/ui/home/cubit/states/faculty_info_state.dart';
import 'package:faculty/ui/home/cubit/states/faculty_info_cubit.dart';

import 'package:faculty/ui/home/newsDetails.dart';
import 'package:faculty/utils/colorManager.dart';

import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  final String searchQuery;
  
  HomeScreen({super.key, this.searchQuery = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String routeName = 'HomeScreen';

  // Helper method to check if text contains search query
  bool _containsSearchQuery(String? text) {
    if (text == null || text.isEmpty || widget.searchQuery.isEmpty) {
      return true;
    }
    
    // Normalize Arabic text and remove diacritics for better matching
    String normalizedText = text.trim().toLowerCase();
    String normalizedQuery = widget.searchQuery.trim().toLowerCase();
    
    // Remove Arabic diacritics (tashkeel)
    normalizedText = normalizedText.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');
    normalizedQuery = normalizedQuery.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');
    
    print('Searching for: "$normalizedQuery" in text: "$normalizedText"');
    
    return normalizedText.contains(normalizedQuery);
  }

  // Filter news based on search query
  List<dynamic> _filterNews(List<dynamic> news) {
    if (widget.searchQuery.isEmpty) {
      return news;
    }
    
    print('Filtering ${news.length} news items with query: "${widget.searchQuery}"');
    
    final filtered = news.where((item) {
      bool matchesTitle = _containsSearchQuery(item.title);
      bool matchesContent = _containsSearchQuery(item.content);
      bool matchesDate = _containsSearchQuery(item.eventDate);
      
      print('News "${item.title}": title=$matchesTitle, content=$matchesContent, date=$matchesDate');
      
      return matchesTitle || matchesContent || matchesDate;
    }).toList();
    
    print('Found ${filtered.length} matching news items');
    return filtered;
  }

  // Filter vision/mission based on search query
  List<dynamic> _filterVisionMission(List<dynamic> visionMissions) {
    if (widget.searchQuery.isEmpty) {
      return visionMissions;
    }
    
    print('Filtering ${visionMissions.length} vision/mission items with query: "${widget.searchQuery}"');
    
    final filtered = visionMissions.where((item) {
      bool matchesTitle = _containsSearchQuery(item.title);
      bool matchesContent = _containsSearchQuery(item.content);
      
      print('Vision/Mission "${item.title}": title=$matchesTitle, content=$matchesContent');
      
      return matchesTitle || matchesContent;
    }).toList();
    
    print('Found ${filtered.length} matching vision/mission items');
    return filtered;
  }

  // Video player controller
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    context.read<VisionMissionCubit>().getVisionMission();
    context.read<FacultyInfoCubit>().getFacultyInfo();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  // Initialize video player
  void _initializeVideo(String videoUrl) {
    _videoController?.dispose();
    _videoController = VideoPlayerController.network(videoUrl);
    _videoController!.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: BlocBuilder<VisionMissionCubit, VisionMissionState>(
        builder: (context, visionState) {
          if (visionState is VisionMissionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (visionState is VisionMissionError) {
            return Center(child: Text(visionState.message));
          } else if (visionState is VisionMissionSuccess) {
            // Filter vision/mission data based on search query
            final filteredVisionMissions = _filterVisionMission(visionState.visionMissions);
             
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Show search results message if searching
                  if (widget.searchQuery.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: MyColors.yellowColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColors.yellowColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: MyColors.yellowColor, size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'نتائج البحث عن: "${widget.searchQuery}"',
                                style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                  // Only show main image if not searching
                  if (widget.searchQuery.isEmpty) ...[
                    
                    BlocBuilder<FacultyInfoCubit, FacultyInfoState>(
                      builder: (context, facultyInfoState) {
                        if (facultyInfoState is FacultyInfoLoading) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (facultyInfoState is FacultyInfoSuccess && facultyInfoState.facultyInfo.isNotEmpty) {
                          final facultyInfo = facultyInfoState.facultyInfo.first;
                          // Initialize video if not already done
                          if (_videoController == null && facultyInfo.video != null) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _initializeVideo(facultyInfo.video!);
                            });
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              SizedBox(height: 15.h),
                              // Video Player
                              if (facultyInfo.video != null) ...[
                                Container(
                                 width: MediaQuery.of(context).size.width,
                                  height: 200.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: _isVideoInitialized && _videoController != null
                                        ? Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(27.0),
                                                child: ClipRRect(
                                                   borderRadius: BorderRadius.circular(10),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 200.h,
                                                    child: VideoPlayer(_videoController!),
                                                  ),
                                                ),
                                              ),
                                              // Play/Pause Button
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_videoController!.value.isPlaying) {
                                                      _videoController!.pause();
                                                    } else {
                                                      _videoController!.play();
                                                    }
                                                  });
                                               },
                                                child: Container(
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    
                                                    color: MyColors.secondryColor.withOpacity(0),
                                                  //   shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(15),
                                                    child: Icon(
                                                      _videoController!.value.isPlaying
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                     color: Color(0xFFDBD8D8).withOpacity(.7),
                                                      size: 80,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'جاري تحميل الفيديو...',
                                                    style: TextStyle(
                                                      color: MyColors.greyColor,
                                                      fontFamily: "Noto Kufi Arabic",
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        } else if (facultyInfoState is FacultyInfoError) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.red, size: 20),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'حدث خطأ في تحميل الفيديو',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Noto Kufi Arabic",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 5.h),
                  ],
                  
                  // Show filtered vision/mission data
                  if (filteredVisionMissions.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.searchQuery.isEmpty) ...[
                            Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SvgPicture.asset("assets/images/Group 65.svg"),
                      ),
                      Text(
                        "الرؤية و الرسالة",
                        style: TextStyle(
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: ColorManager.textColor1,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                            SizedBox(height: 15.h),
                          ],
                          
                          // Display filtered vision/mission items
                          ...filteredVisionMissions.map((visionMission) => 
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    visionMission.title ?? "",
                                    style: TextStyle(
                                      height: 1.h,
                                      fontFamily: "Noto Kufi Arabic",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: MyColors.yellowColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          visionMission.content ?? "",
                                          style: TextStyle(
                                            color: MyColors.softBlackColor,
                                            height: 1.7.h,
                                            fontFamily: "Noto Kufi Arabic",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                          textAlign: TextAlign.right,
                                          softWrap: true,
                                        ),
                                      ),
                                     SvgPicture.asset(
                                       visionMission.id == filteredVisionMissions[0].id 
                                        ? "assets/images/vision.svg"
                                         : "assets/images/message.svg",
                                       fit: BoxFit.contain,
                                     ),
                                      SizedBox(width: 10.w),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ).toList(),
                        ],
                      ),
                    ),
                  ] else if (widget.searchQuery.isNotEmpty) ...[
                    // Show no results message
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: MyColors.greyColor,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'لا توجد نتائج للبحث عن: "${widget.searchQuery}"',
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'جرب البحث بكلمات مختلفة',
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontFamily: "Noto Kufi Arabic",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 342.w,
                    child: Divider(
                      color: Color(0XFFD4D4D4),
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.searchQuery.isEmpty ? "أحدث الفعاليات والأخبار" : "نتائج البحث في الأخبار",
                        style: TextStyle(
                          color: MyColors.softBlackColor,
                          fontSize: 15.sp,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    height: 220.h,
                    child: BlocBuilder<NewsCubit, NewsStates>(
                      builder: (context, newsState) {
                        if (newsState is NewsLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (newsState is NewsErrorState) {
                          return Center(child: Text(newsState.error));
                        } else if (newsState is NewsSuccessState) {
                          // Filter news based on search query
                          final filteredNews = _filterNews(newsState.news);
                          
                          if (filteredNews.isEmpty && widget.searchQuery.isNotEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.article_outlined,
                                    size: 50,
                                    color: MyColors.greyColor,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'لا توجد أخبار تطابق البحث',
                                    style: TextStyle(
                                      color: MyColors.greyColor,
                                      fontFamily: "Noto Kufi Arabic",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredNews.length,
                            itemBuilder: (context, index) {
                              final news = filteredNews[index];

                              return Container(
                              
                                width: 147.w,
                              
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.vertical(top: Radius.circular(15)),
                                      child: Image.network(
                                        news.image ?? "",
                                        width: 147.w,
                                        height: 109.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Image.asset("assets/images/doctors.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            news.title ?? "خبر",
                                             overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            style: TextStyle(
                                              color: MyColors.blackColor,
                                              fontSize: 8.sp,
                                              fontFamily: "Noto Kufi Arabic",
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(
                                            color: Color(0XFFD4D4D4),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                news.eventDate ?? "",
                                                style: TextStyle(
                                                  fontSize: 7.sp,
                                                  color: MyColors.greyColor,
                                                  fontFamily: "Noto Kufi Arabic",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Newsdetails(news: news),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "التفاصيل",
                                                  style: TextStyle(
                                                      color: MyColors.yellowColor),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color: MyColors.yellowColor,
                                                      width: 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10, vertical: 2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
