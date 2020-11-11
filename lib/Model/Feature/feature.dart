class Feature {
  Feature({
    this.id,
    this.productId,
    this.featureId,
    this.rate,
    this.status,
    this.feature,
    this.product,
  });

  int id;
  int productId;
  int featureId;
  double rate;
  bool status;
  FeatureClass feature;
  dynamic product;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        featureId: json["featureId"] == null ? null : json["featureId"],
        rate: json["rate"] == null ? null : json["rate"],
        status: json["status"] == null ? null : json["status"],
        feature: json["feature"] == null
            ? null
            : FeatureClass.fromJson(json["feature"]),
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "featureId": featureId == null ? null : featureId,
        "rate": rate == null ? null : rate,
        "status": status == null ? null : status,
        "feature": feature == null ? null : feature.toJson(),
        "product": product,
      };
}

class FeatureClass {
  FeatureClass({
    this.id,
    this.featureName,
    this.featureId,
    this.status,
  });

  int id;
  String featureName;
  int featureId;
  bool status;

  factory FeatureClass.fromJson(Map<String, dynamic> json) => FeatureClass(
        id: json["id"] == null ? null : json["id"],
        featureName: json["featureName"] == null ? null : json["featureName"],
        featureId: json["featureId"] == null ? null : json["featureId"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "featureName": featureName == null ? null : featureName,
        "featureId": featureId == null ? null : featureId,
        "status": status == null ? null : status,
      };
}
