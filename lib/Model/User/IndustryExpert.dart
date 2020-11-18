class IndustryExpert {
  IndustryExpert({
    this.industryId,
    this.userId,
    this.expertLevel,
    this.interestLevel,
    this.status,
    this.id,
    this.industry,
  });

  int industryId;
  int userId;
  int expertLevel;
  int interestLevel;
  bool status;
  int id;
  Industry industry;

  factory IndustryExpert.fromJson(Map<String, dynamic> json) => IndustryExpert(
        industryId: json["industryId"],
        userId: json["userId"],
        expertLevel: json["expertLevel"],
        interestLevel: json["interestLevel"],
        status: json["status"],
        id: json["id"],
        industry: Industry.fromJson(json["industry"]),
      );

  Map<String, dynamic> toJson() => {
        "industryId": industryId,
        "userId": userId,
        "expertLevel": expertLevel,
        "interestLevel": interestLevel,
        "status": status,
        "id": id,
        "industry": industry.toJson(),
      };
}

class Industry {
  Industry({
    this.id,
    this.name,
    this.status,
    this.industryExperts,
  });

  int id;
  String name;
  bool status;
  List<dynamic> industryExperts;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        industryExperts: json["industryExperts"] == null
            ? null
            : List<dynamic>.from(json["industryExperts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "industryExperts": List<dynamic>.from(industryExperts.map((x) => x)),
      };
}
