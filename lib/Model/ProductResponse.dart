import 'package:swd_project/Model/Product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;

  ProductResponse(this.products, this.error);

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json[" "] as List)
            .map<Product>((i) => new Product.fromJson(i))
            .toList()
            .cast<Product>(),
        error = "";

  ProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}
