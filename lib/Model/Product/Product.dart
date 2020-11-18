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

import 'package:swd_project/Model/Feature/feature.dart';
import 'package:swd_project/Model/Pricing/Pricing.dart';

class Product {
  final int id;
  final String name;
  final String iconUrl;
  final String overview;
  final String description;
  final String url;
  final String backgroundImageUrl;
  final dynamic rating;
  Company company;
  final int userId;
  dynamic userInterests;
  List<ProductMedia> productMedia;
  List<ProductPrice> productPrices;
  List<ProductFeature> productFeatures;

  Product(
      {this.id,
      this.name,
      this.iconUrl,
      this.overview,
      this.description,
      this.url,
      this.rating,
      this.company,
      this.userId,
      this.backgroundImageUrl,
      this.productMedia,
      this.productPrices,
      this.userInterests,
      this.productFeatures});

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
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        userId: json["userId"] == null ? null : json["userId"],
        userInterests: json["userInterests"],
        productMedia: json["productMedia"] == null
            ? null
            : List<ProductMedia>.from(
                json["productMedia"].map((x) => ProductMedia.fromJson(x))),
        productPrices: json["productPrices"] == null
            ? null
            : List<ProductPrice>.from(
                json["productPrices"].map((x) => ProductPrice.fromJson(x))),
        productFeatures: json["productFeatures"] == null
            ? null
            : List<ProductFeature>.from(
                json["productFeatures"].map((x) => ProductFeature.fromJson(x))),
      );
}

class Company {
  Company({
    this.id,
    this.name,
    this.url,
    this.location,
    this.yearFounded,
    this.status,
    this.products,
    this.workFors,
  });

  int id;
  String name;
  String url;
  String location;
  int yearFounded;
  bool status;
  List<dynamic> products;
  List<dynamic> workFors;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        location: json["location"] == null ? null : json["location"],
        yearFounded: json["yearFounded"] == null ? null : json["yearFounded"],
        status: json["status"] == null ? null : json["status"],
        products: json["products"] == null
            ? null
            : List<dynamic>.from(json["products"].map((x) => x)),
        workFors: json["workFors"] == null
            ? null
            : List<dynamic>.from(json["workFors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "location": location == null ? null : location,
        "yearFounded": yearFounded == null ? null : yearFounded,
        "status": status == null ? null : status,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x)),
        "workFors": workFors == null
            ? null
            : List<dynamic>.from(workFors.map((x) => x)),
      };
}

class ProductFeature {
  ProductFeature({
    this.id,
    this.productId,
    this.featureId,
    this.rate,
    this.status,
    this.rateCount,
    this.feature,
  });

  int id;
  int productId;
  int featureId;
  double rate;
  bool status;
  int rateCount;
  Feature feature;

  factory ProductFeature.fromJson(Map<String, dynamic> json) => ProductFeature(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        featureId: json["featureId"] == null ? null : json["featureId"],
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        rateCount: json["rateCount"] == null ? null : json["rateCount"],
        feature:
            json["feature"] == null ? null : Feature.fromJson(json["feature"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "featureId": featureId == null ? null : featureId,
        "rate": rate == null ? null : rate,
        "status": status == null ? null : status,
        "rateCount": rateCount == null ? null : rateCount,
        "feature": feature == null ? null : feature.toJson(),
      };
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

class ProductPrice {
  ProductPrice({
    this.id,
    this.productId,
    this.priceTypeId,
    this.price,
    this.discount,
    this.description,
    this.status,
    this.priceType,
    this.productPriceInfos,
  });

  int id;
  int productId;
  int priceTypeId;
  double price;
  double discount;
  String description;
  bool status;
  PriceType priceType;
  List<ProductPriceInfo> productPriceInfos;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        priceTypeId: json["priceTypeId"] == null ? null : json["priceTypeId"],
        price: json["price"] == null ? null : json["price"],
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        priceType: json["priceType"] == null
            ? null
            : PriceType.fromJson(json["priceType"]),
        productPriceInfos: json["productPriceInfos"] == null
            ? null
            : List<ProductPriceInfo>.from(json["productPriceInfos"]
                .map((x) => ProductPriceInfo.fromJson(x))),
      );
}
