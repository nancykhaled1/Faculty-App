import 'package:faculty/ui/home/newsDetails.dart';
import 'package:faculty/ui/home/newsModel.dart';
import 'package:faculty/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
final List<News> newsList = [
  News(
    title:"زيارة معالى رئيس جامعة دمنهور لكلية الحاسبات والمعلومات بالنوبارية",
    
    content:'''أجرى الأستاذ الدكتور / إلهامي ترابيس - رئيس جامعة دمنهور،  فى صباح اليوم جولة تفقدية بكليات قطاع النوبارية،
لمتابعة انتظام سير العملية التعليمية بالفصل الدراسى الأول للعام الجامعي ٢٠٢٤ـ٢٠٢٥،
 وذلك في إطار جولاته الدورية بكليات الجامعة المختلفة للاطمئنان على انتظام سير العملية التعليمية لتقديم أفضل خدمة للطلاب، وتوفير بيئة تعليمية محفزة وداعمة للتفوق والإبداع.
 خلال جولته اطمأن رئيس جامعة دمنهور على توافر وسائل الراحة للطلاب بالمدرجات وقاعات الدراسة، وتذليل أية عقبات قد تواجههم،
 مشيداً  بانتظام المحاضرات في مواعيدها وتواجد أعضاء هيئة التدريس والجهاز الإداري.
 *ترابيس يحث الطلاب على المشاركة في الأنشطة والفعاليات التي تنفذها الجامعة في إطار مبادرة بداية*
 وفي كلمته للطلاب ..  أوصى رئيس جامعة دمنهور بالاستفادة من كافة الخدمات التي تقدمها الكليات لطلابها، والمشاركة في الأنشطة الطلابية المختلفة،
 وكذا المشاركة في الفعاليات والأنشطة التي تنفذها الجامعة في إطار مبادرة "بداية"،
 والتي تساعدهم علي صقل مهاراتهم وتزويدهم بالمعارف اللازمة، إلى جانب اندماجهم مع زملائهم من الكليات المختلفة.
  نقاش مفتوح بين رئيس جامعة دمنهور وأبنائه الطلاب لاستطلاع آرائهم ومدى الرضا عن العملية التعليمية
وأجرى رئيس الجامعة نقاشاً مفتوحاً مع الطلاب، استطلع خلاله أرائهم حول مدى الرضا عن العملية التعليمية، موجهاً جميع الطلاب بضرورة الاجتهاد في الدراسة العلمية والعملية،'''
 ,
 image: "assets/images/newsDetails.svg"
  ),
  News(title: "زيارة معالى رئيس جامعة دمنهور لكلية الحاسبات والمعلومات بالنوبارية", content: ''' أجرى الأستاذ الدكتور / إلهامي ترابيس - رئيس جامعة دمنهور،  فى صباح اليوم جولة تفقدية بكليات قطاع النوبارية،
لمتابعة انتظام سير العملية التعليمية بالفصل الدراسى الأول للعام الجامعي ٢٠٢٤ـ٢٠٢٥،
 وذلك في إطار جولاته الدورية بكليات الجامعة المختلفة للاطمئنان على انتظام سير العملية التعليمية لتقديم أفضل خدمة للطلاب، وتوفير بيئة تعليمية محفزة وداعمة للتفوق والإبداع.
 خلال جولته اطمأن رئيس جامعة دمنهور على توافر وسائل الراحة للطلاب بالمدرجات وقاعات الدراسة، وتذليل أية عقبات قد تواجههم،
 مشيداً  بانتظام المحاضرات في مواعيدها وتواجد أعضاء هيئة التدريس والجهاز الإداري.
 *ترابيس يحث الطلاب على المشاركة في الأنشطة والفعاليات التي تنفذها الجامعة في إطار مبادرة بداية*
 وفي كلمته للطلاب ..  أوصى رئيس جامعة دمنهور بالاستفادة من كافة الخدمات التي تقدمها الكليات لطلابها، والمشاركة في الأنشطة الطلابية المختلفة،
 وكذا المشاركة في الفعاليات والأنشطة التي تنفذها الجامعة في إطار مبادرة "بداية"،
 والتي تساعدهم علي صقل مهاراتهم وتزويدهم بالمعارف اللازمة، إلى جانب اندماجهم مع زملائهم من الكليات المختلفة.
  نقاش مفتوح بين رئيس جامعة دمنهور وأبنائه الطلاب لاستطلاع آرائهم ومدى الرضا عن العملية التعليمية
وأجرى رئيس الجامعة نقاشاً مفتوحاً مع الطلاب، استطلع خلاله أرائهم حول مدى الرضا عن العملية التعليمية، موجهاً جميع الطلاب بضرورة الاجتهاد في الدراسة العلمية والعملية،''', image: "assets/images/newsDetails.svg"),
  News(title: "زيارة معالى رئيس جامعة دمنهور لكلية الحاسبات والمعلومات بالنوبارية", content:  ''' أجرى الأستاذ الدكتور / إلهامي ترابيس - رئيس جامعة دمنهور،  فى صباح اليوم جولة تفقدية بكليات قطاع النوبارية،
لمتابعة انتظام سير العملية التعليمية بالفصل الدراسى الأول للعام الجامعي ٢٠٢٤ـ٢٠٢٥،
 وذلك في إطار جولاته الدورية بكليات الجامعة المختلفة للاطمئنان على انتظام سير العملية التعليمية لتقديم أفضل خدمة للطلاب، وتوفير بيئة تعليمية محفزة وداعمة للتفوق والإبداع.
 خلال جولته اطمأن رئيس جامعة دمنهور على توافر وسائل الراحة للطلاب بالمدرجات وقاعات الدراسة، وتذليل أية عقبات قد تواجههم،
 مشيداً  بانتظام المحاضرات في مواعيدها وتواجد أعضاء هيئة التدريس والجهاز الإداري.
 *ترابيس يحث الطلاب على المشاركة في الأنشطة والفعاليات التي تنفذها الجامعة في إطار مبادرة بداية*
 وفي كلمته للطلاب ..  أوصى رئيس جامعة دمنهور بالاستفادة من كافة الخدمات التي تقدمها الكليات لطلابها، والمشاركة في الأنشطة الطلابية المختلفة،
 وكذا المشاركة في الفعاليات والأنشطة التي تنفذها الجامعة في إطار مبادرة "بداية"،
 والتي تساعدهم علي صقل مهاراتهم وتزويدهم بالمعارف اللازمة، إلى جانب اندماجهم مع زملائهم من الكليات المختلفة.
  نقاش مفتوح بين رئيس جامعة دمنهور وأبنائه الطلاب لاستطلاع آرائهم ومدى الرضا عن العملية التعليمية
وأجرى رئيس الجامعة نقاشاً مفتوحاً مع الطلاب، استطلع خلاله أرائهم حول مدى الرضا عن العملية التعليمية، موجهاً جميع الطلاب بضرورة الاجتهاد في الدراسة العلمية والعملية، ''', image: "assets/images/newsDetails.svg"),
  
];
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/Rectangle 40.png",
                  width: 342.w,
                  height: 242.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Group 65.svg"),
                      Text(
                        "الرؤية و الرسالة",
                        style: TextStyle(
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "الرؤية والتخطيط",
                          style: TextStyle(
                            height: 1.h,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                            fontSize: 8.sp,
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
                                "تسعى كلية الحاسبات والمعلومات - جامعة دمنهور إلى التميز والريادة والإبتكار في مجالات التعليم والبحث العلمي، وخدمة المجتمع على المستوى المحلي والإقليمي والعالمي.",
                                style: TextStyle(
                                  color: MyColors.softBlackColor,
                                  height: 2.h,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8.sp,
                                ),
                                textAlign: TextAlign.right,
                                softWrap: true,
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/vision.svg",
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 10.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "رسالة الكلية",
                          style: TextStyle(
                            height: 1.h,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                            fontSize: 8.sp,
                            color: MyColors.yellowColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "إعداد خريجين متميزين في مجالات الحاسب الآلي ونظم وتكنولوجيا المعلومات وفقا لمتطلبات سوق العمل، وطبقا للمواصفات العالمية، وتعزيز الاستفادة من نتائج البحث العلمي في مجالات الحاسب الآلي ونظم وتكنولوجيا المعلومات بما يحقق مردود مجتمعي إيجابي وتقديم خدمات مميزة للمجتمع وفق المجالات المتاحة بالكلية",
                                style: TextStyle(
                                  color: MyColors.softBlackColor,
                                  height: 2.h,
                                  fontFamily: "Noto Kufi Arabic",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8.sp,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SvgPicture.asset("assets/images/message.svg"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                  "أحدث الفعاليات والأخبار",
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
              height: 260.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
               itemCount: widget.newsList.length,

                itemBuilder: (context, index) {
                 final news = widget.newsList[index];

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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: SvgPicture.asset(
                                       news.image,
                            width: 147.w,
                            height: 109.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text(
                               news.title,

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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "17 Oct, 2024",
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
                                         builder: (context) => Newsdetails(news: widget.newsList[index]),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "التفاصيل",
                                      style: TextStyle(color: MyColors.yellowColor),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: MyColors.yellowColor, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
