class Pricing {
  Pricing({
    this.id,
    this.productId,
    this.priceTypeId,
    this.price,
    this.description,
    this.discount,
    this.status,
    this.priceType,
    this.product,
    this.productPriceInfos,
  });

  int id;
  int productId;
  int priceTypeId;
  double price;
  String description;
  double discount;
  bool status;
  PriceType priceType;
  dynamic product;
  List<ProductPriceInfo> productPriceInfos;

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        priceTypeId: json["priceTypeId"] == null ? null : json["priceTypeId"],
        price: json["price"] == null ? null : json["price"],
        description: json["description"] == null ? null : json["description"],
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        priceType: json["priceType"] == null
            ? null
            : PriceType.fromJson(json["priceType"]),
        product: json["product"],
        productPriceInfos: json["productPriceInfos"] == null
            ? null
            : List<ProductPriceInfo>.from(json["productPriceInfos"]
                .map((x) => ProductPriceInfo.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //   "id": id == null ? null : id,
  //   "productId": productId == null ? null : productId,
  //   "priceTypeId": priceTypeId == null ? null : priceTypeId,
  //   "price": price == null ? null : price,
  //   "description": description == null ? null : description,
  //   "discount": discount == null ? null : discount,
  //   "status": status == null ? null : status,
  //   "priceType": priceType == null ? null : priceType.toJson(),
  //   "product": product,
  //   "productPriceInfos": productPriceInfos == null ? null : List<dynamic>.from(productPriceInfos.map((x) => x.toJson())),
  // };
}

class PriceType {
  PriceType({
    this.id,
    this.name,
    this.status,
    this.productPrices,
  });

  int id;
  String name;
  bool status;
  List<dynamic> productPrices;

  factory PriceType.fromJson(Map<String, dynamic> json) => PriceType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        productPrices: json["productPrices"] == null
            ? null
            : List<dynamic>.from(json["productPrices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "productPrices": productPrices == null
            ? null
            : List<dynamic>.from(productPrices.map((x) => x)),
      };
}

class ProductPriceInfo {
  ProductPriceInfo({
    this.id,
    this.productPriceId,
    this.inforText,
  });

  int id;
  int productPriceId;
  String inforText;

  factory ProductPriceInfo.fromJson(Map<String, dynamic> json) =>
      ProductPriceInfo(
        id: json["id"] == null ? null : json["id"],
        productPriceId:
            json["productPriceId"] == null ? null : json["productPriceId"],
        inforText: json["inforText"] == null ? null : json["inforText"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productPriceId": productPriceId == null ? null : productPriceId,
        "inforText": inforText == null ? null : inforText,
      };
}
