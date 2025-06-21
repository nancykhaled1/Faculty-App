/// id : 1
/// type : "خدمات اليكترونية"
/// title : "خدمات اعضاء هيئة التدريس"
/// name : "اللائحة والقوانين"
/// description : "اذا كنت تريد معرفة تفاصيل عن اللائحة والقوانين"
/// image : "https://res.cloudinary.com/diubywm4o/image/upload/v1/damanhour/Section/images/protected_qbuxxq"
/// link : null
/// pdf : "https://res.cloudinary.com/diubywm4o/raw/upload/v1/damanhour/Section/pdfs/%D9%84%D8%A7%D9%8A%D8%AD%D8%A9_%D9%83%D9%84%D9%8A%D8%A9_%D8%A7%D9%84%D8%AD%D8%A7%D8%B3%D8%A8%D8%A7%D8%AA_%D9%88%D8%A7%D9%84%D9%85%D8%B9%D9%84%D9%88%D9%85%D8%A7%D8%AA_-_%D8%AC%D8%A7%D9%85%D8%B9%D8%A9_%D8%AF%D9%85%D9%86%D9%87%D9%88%D8%B1_1_kdwelj"

class StudentResponseEntity {
  StudentResponseEntity({
    this.id,
    this.type,
    this.title,
    this.name,
    this.description,
    this.image,
    this.link,
    this.pdf,});


  int? id;
  String? type;
  String? title;
  String? name;
  String? description;
  String? image;
  dynamic link;
  String? pdf;



}