class NewsModel {
  int? id;
  String? image;
  String? title;
  String? content;
  String? eventDate;
  List<NewsImage>? images;

  NewsModel({
    this.id,
    this.image,
    this.title,
    this.content,
    this.eventDate,
    this.images,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    content = json['content'];
    eventDate = json['event_date'];
    if (json['images'] != null) {
      images = <NewsImage>[];
      json['images'].forEach((v) {
        images!.add(new NewsImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['content'] = this.content;
    data['event_date'] = this.eventDate;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsImage {
  int? id;
  String? image;
  int? newsArticle;

  NewsImage({
    this.id,
    this.image,
    this.newsArticle,
  });

  NewsImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    newsArticle = json['news_article'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['news_article'] = this.newsArticle;
    return data;
  }
}
