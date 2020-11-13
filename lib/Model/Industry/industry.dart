class Industry {
  Industry({
    this.productId,
    this.industryId,
    this.industry,
  });

  int productId;
  int industryId;
  IndustryClass industry;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        productId: json["productId"] == null ? null : json["productId"],
        industryId: json["industryId"] == null ? null : json["industryId"],
        industry: json["industry"] == null
            ? null
            : IndustryClass.fromJson(json["industry"]),
      );
}

class IndustryClass {
  IndustryClass({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory IndustryClass.fromJson(Map<String, dynamic> json) => IndustryClass(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
