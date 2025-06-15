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

class DepartmentResponseEntity {
  DepartmentResponseEntity({
    this.id,
    this.name,
    this.about,
    this.image,
    this.vision,
    this.mission,
    this.doctors,
    this.doctorsDetail,
    this.pdf,
    this.createdAt,
    this.updatedAt,});


  int? id;
  String? name;
  String? about;
  String? image;
  String? vision;
  String? mission;
  List<int>? doctors;
  List<DoctorsDetailEntity>? doctorsDetail;
  String? pdf;
  String? createdAt;
  String? updatedAt;



}

/// id : 2
/// cv : "https://res.cloudinary.com/diubywm4o/raw/upload/v1747739726/damanhour/Staff/pdfs/inr5jqyo9v567ppxutoc.pdf"
/// position : "مدرس"
/// image : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/staff_images/Dr.Amr_itnrkz"
/// name : "د / ولاء محمد السيد محمود"

class DoctorsDetailEntity {
  DoctorsDetailEntity({
    this.id,
    this.cv,
    this.position,
    this.image,
    this.name,});


  int? id;
  String? cv;
  String? position;
  String? image;
  String? name;



}