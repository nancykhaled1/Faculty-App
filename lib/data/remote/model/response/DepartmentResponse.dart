import 'package:faculty/domain/entities/departmentEntity.dart';
import 'package:faculty/data/models/response/academic_year_model.dart';

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

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    try {
      print('🔍 Starting DepartmentResponse.fromJson');
      print('🔍 Input JSON: $json');
      
      // فحص كل حقل قبل المعالجة
      print('🔍 Checking all fields before processing:');
      json.forEach((key, value) {
        print('  - $key: $value (type: ${value?.runtimeType})');
      });
      
      // معالجة كل حقل بشكل منفصل مع try-catch
      int? id;
      try {
        print('🔍 Processing id field: ${json['id']}');
        id = _safeParseInt(json['id']);
        print('✅ id processed successfully: $id');
      } catch (e) {
        print('❌ Error processing id: $e');
        id = null;
      }
      
      String? name;
      try {
        print('🔍 Processing name field: ${json['name']}');
        name = json['name']?.toString();
        print('✅ name processed successfully: $name');
      } catch (e) {
        print('❌ Error processing name: $e');
        name = null;
      }
      
      String? about;
      try {
        print('🔍 Processing about field: ${json['about']}');
        about = json['about']?.toString();
        print('✅ about processed successfully: $about');
      } catch (e) {
        print('❌ Error processing about: $e');
        about = null;
      }
      
      String? image;
      try {
        print('🔍 Processing image field: ${json['image']}');
        image = _prependBaseUrl(json['image']);
        print('✅ image processed successfully: $image');
      } catch (e) {
        print('❌ Error processing image: $e');
        image = null;
      }
      
      String? vision;
      try {
        print('🔍 Processing vision field: ${json['vision']}');
        vision = json['vision']?.toString();
        print('✅ vision processed successfully: $vision');
      } catch (e) {
        print('❌ Error processing vision: $e');
        vision = null;
      }
      
      String? mission;
      try {
        print('🔍 Processing mission field: ${json['mission']}');
        mission = json['mission']?.toString();
        print('✅ mission processed successfully: $mission');
      } catch (e) {
        print('❌ Error processing mission: $e');
        mission = null;
      }
      
      List<int>? doctors;
      try {
        print('🔍 Processing doctors field: ${json['doctors']}');
        if (json['doctors'] != null) {
          doctors = (json['doctors'] as List)
              .map((doctorJson) {
                print('🔍 Processing doctor: $doctorJson');
                return _safeParseInt(doctorJson);
              })
              .where((id) => id != null)
              .cast<int>()
              .toList();
        }
        print('✅ doctors processed successfully: ${doctors?.length} doctors');
      } catch (e) {
        print('❌ Error processing doctors: $e');
        doctors = null;
      }
      
      List<DoctorsDetailEntity>? doctorsDetail;
      try {
        print('🔍 Processing doctors_detail field: ${json['doctors_detail']}');
        if (json['doctors_detail'] != null) {
          doctorsDetail = (json['doctors_detail'] as List)
              .map((doctorJson) {
                print('🔍 Processing doctor: $doctorJson');
                return DoctorsDetail.fromJson(doctorJson);
              })
              .toList();
        }
        print('✅ doctors_detail processed successfully: ${doctorsDetail?.length} doctors');
      } catch (e) {
        print('❌ Error processing doctors_detail: $e');
        doctorsDetail = null;
      }
      
      String? pdf;
      try {
        print('🔍 Processing pdf field: ${json['pdf']}');
        pdf = json['pdf']?.toString();
        print('✅ pdf processed successfully: $pdf');
      } catch (e) {
        print('❌ Error processing pdf: $e');
        pdf = null;
      }
      
      String? createdAt;
      try {
        print('🔍 Processing created_at field: ${json['created_at']}');
        createdAt = json['created_at']?.toString();
        print('✅ created_at processed successfully: $createdAt');
      } catch (e) {
        print('❌ Error processing created_at: $e');
        createdAt = null;
      }
      
      String? updatedAt;
      try {
        print('🔍 Processing updated_at field: ${json['updated_at']}');
        updatedAt = json['updated_at']?.toString();
        print('✅ updated_at processed successfully: $updatedAt');
      } catch (e) {
        print('❌ Error processing updated_at: $e');
        updatedAt = null;
      }
      
      print('🔍 Creating DepartmentResponse object...');
      var result = DepartmentResponse(
        id: id,
        name: name,
        about: about,
        image: image,
        vision: vision,
        mission: mission,
        doctors: doctors,
        doctorsDetail: doctorsDetail,
        pdf: pdf,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      print('✅ DepartmentResponse.fromJson completed successfully');
      return result;
      
    } catch (e) {
      print('❌ Error in DepartmentResponse.fromJson: $e');
      print('❌ Error stack trace: ${e.toString()}');
      print('❌ JSON data: $json');
      rethrow;
    }
  }

  static int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        // فحص إذا كان الـ string يحتوي على URL
        if (value.contains('://') || value.startsWith('//')) {
          print('⚠️ Warning: Attempting to parse URL as int: $value');
          return null;
        }
        return int.parse(value);
      } catch (e) {
        print('❌ Error parsing int from string: $value');
        print('❌ Error details: $e');
        return null;
      }
    }
    print('⚠️ Warning: Unknown type for int parsing: $value (${value.runtimeType})');
    return null;
  }

  static List<int>? _safeParseIntList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      try {
        print('🔍 Processing int list with ${value.length} items');
        List<int> result = [];
        for (int i = 0; i < value.length; i++) {
          try {
            print('🔍 Processing list item $i: ${value[i]} (type: ${value[i]?.runtimeType})');
            var parsed = _safeParseInt(value[i]);
            if (parsed != null) {
              result.add(parsed);
              print('✅ List item $i processed successfully: $parsed');
            } else {
              print('⚠️ List item $i is null, skipping');
            }
          } catch (itemError) {
            print('❌ Error processing list item $i: $itemError');
            print('❌ Item data: ${value[i]}');
          }
        }
        print('✅ Int list processed successfully: $result');
        return result;
      } catch (e) {
        print('❌ Error parsing int list: $e');
        return null;
      }
    }
    print('⚠️ Warning: Value is not a list: $value (${value.runtimeType})');
    return null;
  }

  static DoctorsDetailEntity? _safeParseDoctorsDetail(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) {
      try {
        print('🔍 Processing doctor detail: $value');
        var doctor = DoctorsDetail.fromJson(value);
        print('✅ Doctor detail processed successfully');
        return doctor;
      } catch (e) {
        print('❌ Error parsing doctor detail: $e');
        return null;
      }
    }
    print('⚠️ Warning: Value is not a Map: $value (${value.runtimeType})');
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['about'] = about;
    data['image'] = image;
    data['vision'] = vision;
    data['mission'] = mission;
    data['doctors'] = doctors;
    if (doctorsDetail != null) {
      data['doctors_detail'] = doctorsDetail?.map((v) {
        if (v is DoctorsDetail) {
          return v.toJson();
        } else {
          // إذا كان v من نوع DoctorsDetailEntity، قم بتحويله يدوياً
          return {
            'id': v.id,
            'cv': v.cv,
            'position': v.position,
            'image': v.image,
            'name': v.name,
          };
        }
      }).toList();
    }
    data['pdf'] = pdf;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
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

  factory DoctorsDetail.fromJson(dynamic json) {
    try {
      print('🔍 Parsing DoctorsDetail JSON: $json');
      
      // فحص كل حقل قبل التحويل
      print('🔍 doctor id: ${json['id']} (type: ${json['id']?.runtimeType})');
      print('🔍 doctor cv: ${json['cv']} (type: ${json['cv']?.runtimeType})');
      print('🔍 doctor position: ${json['position']} (type: ${json['position']?.runtimeType})');
      print('🔍 doctor image: ${json['image']} (type: ${json['image']?.runtimeType})');
      print('🔍 doctor name: ${json['name']} (type: ${json['name']?.runtimeType})');
      
      // معالجة كل حقل على حدة
      print('🔍 Processing doctor id...');
      var id = DepartmentResponse._safeParseInt(json['id']);
      print('✅ doctor id processed: $id');
      
      print('🔍 Processing doctor cv...');
      var cv = json['cv']?.toString();
      print('✅ doctor cv processed: $cv');
      
      print('🔍 Processing doctor position...');
      var position = json['position']?.toString();
      print('✅ doctor position processed: $position');
      
      print('🔍 Processing doctor image...');
      var image = json['image']?.toString();
      print('✅ doctor image processed: $image');
      
      print('🔍 Processing doctor name...');
      var name = json['name']?.toString();
      print('✅ doctor name processed: $name');
      
      return DoctorsDetail(
        id: id,
        cv: cv,
        position: position,
        image: image,
        name: name,
      );
    } catch (e) {
      print('❌ Error parsing DoctorsDetail: $e');
      print('❌ JSON data: $json');
      return DoctorsDetail();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cv'] = cv;
    data['position'] = position;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}

String? _prependBaseUrl(dynamic url) {
  try {
    if (url == null) return null;
    
    String urlString = url.toString();
    if (urlString.isEmpty) return null;
    
    print('🔍 Processing URL: $urlString');
    
    // إذا كان URL يحتوي على http أو https، ارجعه كما هو
    if (urlString.startsWith('http://') || urlString.startsWith('https://')) {
      print('✅ Full URL detected: $urlString');
      return urlString;
    }
    
    // إذا كان URL يبدأ بـ //، أضف https:
    if (urlString.startsWith('//')) {
      String fullUrl = 'https:$urlString';
      print('✅ Protocol-relative URL converted: $fullUrl');
      return fullUrl;
    }
    
    // إذا كان URL نسبي، أضف baseUrl
    if (!urlString.startsWith('http')) {
      String fullUrl = 'https://smartcollegedmanhour-production.up.railway.app$urlString';
      print('✅ Relative URL converted: $fullUrl');
      return fullUrl;
    }
    
    return urlString;
  } catch (e) {
    print('❌ Error in _prependBaseUrl: $e');
    print('❌ URL value: $url');
    return null;
  }
}