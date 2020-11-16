import 'dart:convert';

import 'package:swd_project/Model/Product/Product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;

  ProductResponse(this.products, this.error);

  ProductResponse.fromJson(String response)
      : products = json
            .decode(response)
            .map<Product>((item) => Product.fromJson(item))
            .toList(),
        error = "";

  ProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}

class ProductDetailResponse {
  final Product productDetail;
  final String error;

  ProductDetailResponse(this.productDetail, this.error);

  ProductDetailResponse.fromJson(String response)
      : productDetail = Product.fromJson(json.decode(response)),
        error = "";

  ProductDetailResponse.withError(String errorValue)
      : productDetail = Product(),
        error = errorValue;
}
