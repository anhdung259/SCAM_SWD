import 'dart:convert';

class Feature {
  Feature({
    this.id,
    this.featureName,
    this.featureId,
    this.status,
    this.productFeatureReviews,
    this.productFeatures,
  });

  int id;
  String featureName;
  int featureId;
  bool status;
  List<dynamic> productFeatureReviews;
  List<dynamic> productFeatures;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] == null ? null : json["id"],
        featureName: json["featureName"] == null ? null : json["featureName"],
        featureId: json["featureId"] == null ? null : json["featureId"],
        status: json["status"] == null ? null : json["status"],
        productFeatureReviews: json["productFeatureReviews"] == null
            ? null
            : List<dynamic>.from(json["productFeatureReviews"].map((x) => x)),
        productFeatures: json["productFeatures"] == null
            ? null
            : List<dynamic>.from(json["productFeatures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "featureName": featureName == null ? null : featureName,
        "featureId": featureId == null ? null : featureId,
        "status": status == null ? null : status,
        "productFeatureReviews": productFeatureReviews == null
            ? null
            : List<dynamic>.from(productFeatureReviews.map((x) => x)),
        "productFeatures": productFeatures == null
            ? null
            : List<dynamic>.from(productFeatures.map((x) => x)),
      };
}

List<FeatureReview> featureReviewFromJson(String str) =>
    List<FeatureReview>.from(
        json.decode(str).map((x) => FeatureReview.fromJson(x)));

String featureReviewToJson(List<FeatureReview> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeatureReview {
  FeatureReview({
    this.id,
    this.productId,
    this.userId,
    this.featureId,
    this.rate,
  });

  int id;
  int productId;
  int userId;
  int featureId;
  dynamic rate;

  factory FeatureReview.fromJson(Map<String, dynamic> json) => FeatureReview(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        userId: json["userId"] == null ? null : json["userId"],
        featureId: json["featureId"] == null ? null : json["featureId"],
        rate: json["rate"] == null ? null : json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "userId": userId == null ? null : userId,
        "featureId": featureId == null ? null : featureId,
        "rate": rate == null ? null : rate,
      };
}
