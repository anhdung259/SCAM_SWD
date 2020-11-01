import 'package:swd_project/Model/Product/Product.dart';

class CategoryWithProduct {
  int id;
  String name;
  int categoryId;
  List<Product> products;
  List<ProductCategory> productCategories;

  CategoryWithProduct(
      {this.id,
      this.name,
      this.categoryId,
      this.products,
      this.productCategories});

  factory CategoryWithProduct.fromJson(Map<String, dynamic> json) =>
      CategoryWithProduct(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        productCategories: List<ProductCategory>.from(
            json["productCategories"].map((x) => ProductCategory.fromJson(x))),
      );
}

class ProductCategory {
  ProductCategory({
    this.productId,
    this.categoryId,
    this.status,
    this.product,
  });

  int productId;
  int categoryId;
  dynamic status;
  Product product;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        productId: json["productId"],
        categoryId: json["categoryId"],
        status: json["status"],
        product: Product.fromJson(json["product"]),
      );
}
