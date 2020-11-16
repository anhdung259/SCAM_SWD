import 'package:swd_project/Model/User/IndustryExpert.dart';

class User {
  User(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.facebook,
      this.phone,
      this.bio,
      this.joinDate,
      this.provider,
      this.role,
      this.status,
      this.products,
      this.industryExperts});

  dynamic id;
  dynamic name;
  dynamic avatarUrl;
  dynamic email;
  dynamic facebook;
  dynamic phone;
  dynamic bio;
  dynamic joinDate;
  dynamic provider;
  dynamic role;
  bool status;
  List<dynamic> products;
  List<IndustryExpert> industryExperts;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
        email: json["email"],
        facebook: json["facebook"],
        phone: json["phone"],
        bio: json["bio"],
        joinDate: json["joinDate"],
        provider: json["provider"],
        role: json["role"],
        status: json["status"],
        industryExperts: List<IndustryExpert>.from(
            json["industryExperts"].map((x) => IndustryExpert.fromJson(x))),
        products: List<dynamic>.from(json["products"].map((x) => x)),
      );
  factory User.fromJsonProfile(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
        email: json["email"],
        facebook: json["facebook"],
        phone: json["phone"],
        bio: json["bio"],
        joinDate: json["joinDate"],
        provider: json["provider"],
        role: json["role"],
        status: json["status"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarUrl": avatarUrl,
        "email": email,
        "facebook": facebook,
        "phone": phone,
        "bio": bio,
        "joinDate": joinDate,
        "provider": provider,
        "role": role,
        "status": status,
        "products": List<dynamic>.from(products.map((x) => x)),
      };
}