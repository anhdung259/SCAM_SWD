class Category {
  Category({
    this.id,
    this.name,
    this.categoryId,
  });

  int id;
  String name;
  dynamic categoryId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
      );
}
