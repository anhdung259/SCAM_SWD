// "id": 0,
// "name": "string",
// "iconUrl": "string",
// "overview": "string",
// "description": "string",
// "url": "string",
// "rating": 0,
// "companyId": 0,
// "userId": 0,
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

  Product(
      this.id,
      this.name,
      this.iconUrl,
      this.overview,
      this.description,
      this.url,
      this.rating,
      this.companyId,
      this.userId,
      this.backgroundImageUrl);

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        iconUrl = json["iconUrl"],
        overview = json["overview"],
        description = json["description"],
        url = json["url"],
        rating = json["rating"],
        companyId = json["companyId"],
        userId = json["userId"],
        backgroundImageUrl = json["backgroundImageUrl"];
}
