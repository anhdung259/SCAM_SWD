// "id": 0,
// "name": "string",
// "iconUrl": "string",
// "overview": "string",
// "description": "string",
// "url": "string",
// "rating": 0,
// "companyId": 0,
// "userId": 0,
import 'dart:core';

class Product {
  final int id;
  final String name;
  final String iconUrl;
  final String overview;
  final String description;
  final String url;
  final String backgroundImageUrl;
  final dynamic rating;
  final int companyId;
  final int userId;
  List<ProductMedia> productMedia;

  Product(
      {this.id,
      this.name,
      this.iconUrl,
      this.overview,
      this.description,
      this.url,
      this.rating,
      this.companyId,
      this.userId,
      this.backgroundImageUrl,
      this.productMedia});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        backgroundImageUrl: json["backgroundImageUrl"] == null
            ? null
            : json["backgroundImageUrl"],
        overview: json["overview"] == null ? null : json["overview"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        companyId: json["companyId"] == null ? null : json["companyId"],
        userId: json["userId"] == null ? null : json["userId"],
        productMedia: json["productMedia"] == null
            ? null
            : List<ProductMedia>.from(
                json["productMedia"].map((x) => ProductMedia.fromJson(x))),
      );
}

class ProductMedia {
  ProductMedia({
    this.id,
    this.productId,
    this.url,
    this.mediaType,
    this.title,
    this.status,
  });

  int id;
  int productId;
  String url;
  String mediaType;
  String title;
  bool status;

  factory ProductMedia.fromJson(Map<String, dynamic> json) => ProductMedia(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        url: json["url"] == null ? null : json["url"],
        mediaType: json["mediaType"] == null ? null : json["mediaType"],
        title: json["title"] == null ? null : json["title"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "url": url == null ? null : url,
        "mediaType": mediaType == null ? null : mediaType,
        "title": title == null ? null : title,
        "status": status == null ? null : status,
      };
}
