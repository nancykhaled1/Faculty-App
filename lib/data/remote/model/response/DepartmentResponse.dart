import 'package:faculty/domain/entities/departmentEntity.dart';

/// id : 2
/// name : "تكنولوجيا المعلومات"
/// about : "في إطار التطور التكنولوجي السريع وخاصة في مجال تقنيات تكنولوجيا المعلومات ، يركز قسم تكنولوجيا المعلومات على تطوير الأساس النظري والمهارات العلمية والتطبيقية اللازمة لإعداد كوادر متخصصين في تطبيقات تكنولوجيا المعلومات وتطوير البرمجيات وتتمثل فى :\r\n\r\n شبكات الحاسب المتقدمة - الوسائط المتعددة المتقدمة - إنترنت الأشياء– إشارات ونظم الشبكات اللاسلكية المتحركة – برمجة الشبكات – الحوسبة السحابية – إدارة الشبكات – تخطيط وتصميم الشبكات – الادلة الشرعية فى الشبكات – الأنظمة المدمجة للشبكات – تأمين شبكات الحاسب – معالجة الإشارات الرقمية – معالجة الصور و بالإضافة أيضا إلى تدريس موضوعات مختارة هدفها إعطاء الفرصة السريعة لأعضاء هيئة التدريس بالقسم لمواكبة التطور العلمي الحديث وتدريس كل ما هو جديد في مجال تكنولوجيا المعلومات"
/// image : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/department/images/download_1_fktcgf"
/// vision : "يرتكز قسم تكنولوجيا المعلومات على توفير التعليم المبتكر والتجارب العملية ومساعدة الطلاب على اكتساب المعرفة والمهارات اللازمة وتنمية قدراتهم ومقومات التطويرالمستمر فى مجالات التكنولوجيا المعلوماتية كالبرمجيات، ونظم المعلومات، وأمن المعلومات، وتحليل البيانات ،  وتوفير فرص البحث والإبتكار والتعاون مع القطاعات الصناعية والأكاديمية والحكومية من أجل تعزيز دور القسم فى مواكبة التحديات التكنولوجية الحديثة وتمكين الطلاب من التأثير الإيجابي في المجتمع والصناعة"
/// mission : "نشأ قسم تكنولوجيا المعلومات بكلية الحاسبات والمعلومات جامعة دمنهور طبقاً للائحة الكلية الكلية الصادرة بالقرار الوزاري رقم (3471) في 8/8/2019 وذلك لتحقيق الريادة في مجال تكنولوجيا المعلومات ويتم ذلك من خلال تقديم مناهج تعليمية متميزة فى مختلف فروع تكنولوجيا المعلومات  وتوفير البيئة الملائمة للتعلم والبحث والابتكار، وأيضا توفير الدعم اللازم للطلاب وأعضاء هيئة التدريس والموظفين في تحقيق أهدافهم الأكاديمية والمهنية  وإعداد كوادر متميزة بمجال تكنولوجيا المعلومات قادرة على الابتكار فى البحث العلمى وخدمة المجتمع بمجال تكنولوجيا المعلومات."
/// doctors : [2]
/// doctors_detail : [{"id":2,"cv":"https://res.cloudinary.com/diubywm4o/raw/upload/v1747739726/damanhour/Staff/pdfs/inr5jqyo9v567ppxutoc.pdf","position":"مدرس","image":"https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/staff_images/Dr.Amr_itnrkz","name":"د / ولاء محمد السيد محمود"}]
/// pdf : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/department/pdfs/%D9%84%D8%A7%D9%8A%D8%AD%D8%A9_%D9%83%D9%84%D9%8A%D8%A9_%D8%A7%D9%84%D8%AD%D8%A7%D8%B3%D8%A8%D8%A7%D8%AA_%D9%88%D8%A7%D9%84%D9%85%D8%B9%D9%84%D9%88%D9%85%D8%A7%D8%AA_-_%D8%AC%D8%A7%D9%85%D8%B9%D8%A9_%D8%AF%D9%85%D9%86%D9%87%D9%88%D8%B1_1_mkcdgy"
/// created_at : "2025-05-20T11:51:34.164328Z"
/// updated_at : "2025-05-20T11:52:02.583472Z"

class DepartmentResponse extends DepartmentResponseEntity{
  DepartmentResponse({
    super.id,
    super.name,
    super.about,
    super.image,
    super.vision,
    super.mission,
    super.doctors,
    super.doctorsDetail,
    super.pdf,
    super.createdAt,
    super.updatedAt,});

  DepartmentResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    about = json['about'];
    image = json['image'];
    vision = json['vision'];
    mission = json['mission'];
    doctors = json['doctors'] != null ? json['doctors'].cast<int>() : [];
    if (json['doctors_detail'] != null) {
      doctorsDetail = [];
      json['doctors_detail'].forEach((v) {
        doctorsDetail?.add(DoctorsDetail.fromJson(v));
      });
    }
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  // int? id;
  // String? name;
  // String? about;
  // String? image;
  // String? vision;
  // String? mission;
  // List<int>? doctors;
  // List<DoctorsDetail>? doctorsDetail;
  // String? pdf;
  // String? createdAt;
  // String? updatedAt;

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['name'] = name;
  //   map['about'] = about;
  //   map['image'] = image;
  //   map['vision'] = vision;
  //   map['mission'] = mission;
  //   map['doctors'] = doctors;
  //   if (doctorsDetail != null) {
  //     map['doctors_detail'] = doctorsDetail?.map((v) => v.toJson()).toList();
  //   }
  //   map['pdf'] = pdf;
  //   map['created_at'] = createdAt;
  //   map['updated_at'] = updatedAt;
  //   return map;
  // }

}

/// id : 2
/// cv : "https://res.cloudinary.com/diubywm4o/raw/upload/v1747739726/damanhour/Staff/pdfs/inr5jqyo9v567ppxutoc.pdf"
/// position : "مدرس"
/// image : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/staff_images/Dr.Amr_itnrkz"
/// name : "د / ولاء محمد السيد محمود"

class DoctorsDetail extends DoctorsDetailEntity{
  DoctorsDetail({
      super.id,
    super.cv,
    super.position,
    super.image,
    super.name,});

  DoctorsDetail.fromJson(dynamic json) {
    id = json['id'];
    cv = json['cv'];
    position = json['position'];
    image = json['image'];
    name = json['name'];
  }
  // int? id;
  // String? cv;
  // String? position;
  // String? image;
  // String? name;
  //
  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['cv'] = cv;
  //   map['position'] = position;
  //   map['image'] = image;
  //   map['name'] = name;
  //   return map;
  // }

}