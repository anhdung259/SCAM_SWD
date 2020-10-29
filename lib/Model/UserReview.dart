class User {
  User({
    this.id,
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
    this.userReviews,
  });

  int id;
  String name;
  String avatarUrl;
  dynamic email;
  dynamic facebook;
  dynamic phone;
  dynamic bio;
  dynamic joinDate;
  dynamic provider;
  String role;
  dynamic status;
  List<dynamic> products;
  List<dynamic> userReviews;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        userReviews: List<dynamic>.from(json["userReviews"].map((x) => x)),
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
        "userReviews": List<dynamic>.from(userReviews.map((x) => x)),
      };
}
